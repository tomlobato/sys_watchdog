class SysWatchdog
    DEFAULT_CONF_FILE = '/etc/sys_watchdog.yml'
    DEFAULT_LOG_FILE  = '/var/log/sys_watchdog.log'

    def initialize conf_file: nil, log_file: nil
        log_file ||= DEFAULT_LOG_FILE
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
            Mail.defaults do
              delivery_method :smtp, address: @conf.smtp_server, port: 587, :domain => @conf.smtp_domain, 
                              :enable_starttls_auto => true, :openssl_verify_mode => 'none'
            end
        end
    end

    def parse_conf conf_file
        raise "Conf file #{conf_file} not found." unless File.exist? conf_file

        conf = YAML.load_file conf_file
        conf.deep_symbolize_keys!

        @conf = OpenStruct.new conf[:config]

        @tests = conf[:tests].keys.map { |name|
            WdTest.new(name, conf[:tests][name], @logger)
        }
    end

    def run_test test, after_restore: false
        new_status, exitstatus, output = test.run

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
                fail test, exitstatus, output
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

    def fail test, exitstatus, output
        body = "exitstatus: #{exitstatus}"
        body += "\noutput: #{output}" if output and not output.empty?
        notify "#{test.name} fail", body
    end
end
