class Main
    def initialize
        @logger = WdLogger.new LOG_FILE
        parse_conf
        setup
        true
    end

    def run
        loop do
            @tests.each{|test| run_test test}
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

    def conf_file
        CONF_FILE.each do |file|
            return file if File.exists? file
        end
        raise "No conf file found."
    end

    def parse_conf
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