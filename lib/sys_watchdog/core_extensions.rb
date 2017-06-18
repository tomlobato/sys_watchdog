class Exception
  def desc
    "#{self.message} #{self.backtrace.join "\n" if self.backtrace}"
  end
end

def log_ex e
  STDERR.puts e.desc
end
