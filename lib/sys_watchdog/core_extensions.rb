class Exception
  def desc
    "#{self.message} #{self.backtrace.join "\n" if self.backtrace}"
  end
end

def log_ex e, msg = nil
  if @logger
    @logger.error e.desc
  else
    STDERR.puts e.desc
  end
end
