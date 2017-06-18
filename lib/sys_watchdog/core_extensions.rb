class Exception
  def desc
    "#{self.message} #{self.backtrace.join "\n" if self.backtrace}"
  end
end