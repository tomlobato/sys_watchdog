class WdTest
    attr_accessor :name, 
                  :test_cmd, :test_url, :restore_cmd,
                  :expected_regex, :expected_max, :expected_min, 
                  :fail

    def initialize name, params, logger
        @logger = logger

        @name = name
        @test_cmd = params[:test_cmd]
        @test_url = params[:test_url]
        @expected_regex = params[:expected_regex]
        @expected_string = params[:expected_string]
        @expected_max = params[:expected_max]
        @expected_min = params[:expected_min]
        @restore_cmd = params[:restore_cmd]

        @fail = false

        setup
    end

    def restore
        exitstatus, output = run_cmd @restore_cmd
        unless exitstatus == 0
            @logger.error "restore exited with non-zero: #{exitstatus} #{output}"
        end
    end

    def run after_restore: false
        @logger.info "testing #{@name}"

        unless @test_cmd.present?
            @logger.error "test cmd or url required"
            return
        end

        exitstatus, output = run_cmd @test_cmd
        success = check_result exitstatus, output

        @logger.info "success: #{success.to_s}"

        [success, exitstatus, output]
    end

    private

    def run_cmd cmd, allow_raise = false
        @logger.info "run: #{ cmd }"

        output = IO.popen(cmd, "r") {|pipe| pipe.read}
        exitstatus = $?.exitstatus

        if exitstatus != 0
            @logger.error "#{cmd} -> #{output}"
        end

        [exitstatus, output]
    end

    def setup
        if @test_url.present?
            @test_cmd = "wget -O - '#{ @test_url }' > /dev/null 2>&1"
        end
        if @expected_regex.present?
            @expected_regex = Regexp.new @expected_regex
        end
    end

    def check_result exitstatus, output
        success = if @expected_regex.present?
            output =~ @expected_regex
        elsif @expected_string.present?
            output == @expected_string
        elsif @expected_max.present?
            output.to_f <= @expected_max
        elsif @expected_min.present?
            output.to_f <= @expected_min
        else
            exitstatus == 0
        end
        !!success
    end
end