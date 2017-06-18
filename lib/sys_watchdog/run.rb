
case ARGV[0]
when 'install'
  Install.install
else
  SysWatchdog.new.run
end