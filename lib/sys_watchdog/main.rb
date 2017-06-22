class SysWatchdog
    DEFAULT_CONF_FILE = '/etc/sys_watchdog.yml'
    DEFAULT_LOG_FILE  = '/var/log/sys_watchdog.log'
    WORKING_DIR = '/var/local/sys_watchdog'
    CRONJOB_PATH = '/etc/cron.d/sys_watchdog'
    INSTALL_TYPE_PATH = "#{WORKING_DIR}/install_type"

    def initialize conf_file: nil, log_file: nil
        log_file  ||= DEFAULT_LOG_FILE
        conf_file ||= DEFAULT_CONF_FILE

        @logger = WdLogger.new log_file
        parse_conf conf_file

        setup
    end

    def run once: false
        loop do
            @tests.each{|test| run_test test}
            return if once
            sleep 60
        end
    end

    private

    def setup
        if @conf.slack_token
            Slack.configure do |config|
              config.token = @conf.slack_token
            end
        end
        if @conf.smtp_server
            conf_ = @conf
            Mail.defaults do
              delivery_method :smtp, address: conf_.smtp_server, port: 587, :domain => conf_.smtp_domain, 
                              :enable_starttls_auto => true, :openssl_verify_mode => 'none'
            end
        end
    end

    def parse_conf conf_file
        check_conf_file conf_file

        conf = YAML.load_file conf_file
        conf.deep_symbolize_keys!

        @conf = OpenStruct.new conf[:config]

        @tests = conf[:tests].keys.map { |name|
            WdTest.new(name, conf[:tests][name], @logger)
        }
    end

    def check_conf_file conf_file
        unless File.readable? conf_file
            raise "Conf file #{conf_file} not found or unreadable. Aborting." 
        end

        conf_stat = File.stat conf_file

        unless conf_stat.mode.to_s(8) =~ /0600$/
            raise "Conf file #{conf_file} must have mode 0600. Aborting." 
        end

        unless match_root_or_current_user(conf_stat)
            raise "Conf file #{conf_file} must have uid/gid set to root or to current running uid/gid. Aborting." 
        end
    end

    def run_test test, after_restore: false
        new_status, _exitstatus, output = test.run

        notify_output_change test, output

        return if new_status == test.status
        test.status = new_status
        
        if new_status
            notify "#{test.name} ok"
        else
            if test.restore_cmd and not after_restore
                test.restore
                run_test test, after_restore: true
            else
                fail test, output
            end
        end
    rescue => e
        @logger.error e.desc
    end

    def notify_output_change test, output
        if test.notify_on_output_change and test.previous_output != output
            notify "#{test.name} changed", "old: #{test.previous_output}\nnew: #{output}"
            test.previous_output = output
        end
    end

    def fail test, output
        body = ""
        body += "output: #{output}" if output and not output.empty?
        notify "#{test.name} fail", body
    end
end
