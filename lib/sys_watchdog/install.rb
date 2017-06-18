
class Install
  def install
    thisdir = File.join File.dirname(__FILE__)
    
    copy "#{thisdir}/../../util/sys_watchdog_sample.yml", 
          SysWatchdog::DEFAULT_CONF_FILE

    copy "#{thisdir}/../../util/sys_watchdog.service", 
         "/lib/systemd/system/"

    run 'systemctl enable sys_watchdog'
  end
  
  private

  def copy from, to
    puts "Copying #{from} to #{to}..."
    FileUtils.cp from, to
  end

  def run cmd
    puts "Running #{cmd}..."
    system cmd
  end
end