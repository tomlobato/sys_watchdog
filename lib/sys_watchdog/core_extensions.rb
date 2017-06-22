class Exception
  def desc
    "#{ message } #{ backtrace&.join "\n" }"
  end
end

def log_ex e
  STDERR.puts e.desc
end

def match_root_or_current_user stat
  (stat.uid == 0           and stat.gid == 0) ||
  (stat.uid == Process.uid and stat.gid == Process.gid)
end
