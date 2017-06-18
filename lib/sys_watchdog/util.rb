module Util
    def log_ex msg, e
        @logger.error "#{e.message} #{e.backtrace.join "\n" if e.backtrace}"
    end
end