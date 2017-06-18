
require 'syslog'
require 'syslog/logger'

class WdLogger < Logger
  SYSLOG_NAME = 'sys_watchdog'

  def initialize *args
    @syslog = Syslog::Logger.new SYSLOG_NAME
    super
  end

  def add(severity, message = nil, progname = nil, &block)
    super

    if message.nil?
      if block_given?
        message = yield
      else
        message = progname
      end
    end

    added severity, message
  end

  def added severity, message
    if severity >= Logger::WARN
      @syslog.send Logger::Severity::constants[severity].downcase, message
    end
  end

end

