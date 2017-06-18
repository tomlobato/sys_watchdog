class SysWatchdog
    def initialize conf_file: nil, log_file: nil
        @logger = WdLogger.new (log_file || DEFAULT_LOG_FILE)
        parse_conf (conf_file || DEFAULT_CONF_FILE)
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
        success, exitstatus, output = test.run
        if success
            if test.fail
                test.fail = false
                notify "#{test.name} ok"
            end
        else
            unless test.fail
                if test.restore_cmd and not after_restore
                    test.restore
                    run_test test, after_restore: true
                else
                    fail test, exitstatus, output
                end
            end
        end
    rescue => e
        log_ex e
    end

    def fail test, exitstatus, output
        test.fail = true
        body = "output: #{output}" if body and not body.empty?
        notify "#{test.name} fail", body
    end
end