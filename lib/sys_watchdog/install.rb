
class Install
  def install
    thisdir = File.join File.dirname(__FILE__)
    services_dir = "/lib/systemd/system/"

    if `which systemctl`.empty?
      STDERR.puts "SysWatchdog install requires systemctl. Aborting."
      exit 1
    end

    unless File.exist? services_dir
      STDERR.puts "SysWatchdog install requires dir #{services_dir}. Aborting."
      exit 1
    end
    
    copy "#{thisdir}/../../util/sys_watchdog_sample.yml", 
          SysWatchdog::DEFAULT_CONF_FILE

    copy "#{thisdir}/../../util/sys_watchdog.service", 
         services_dir

    run 'systemctl enable sys_watchdog'

    puts "Installed."

    puts "\nEdit #{SysWatchdog::DEFAULT_CONF_FILE} and start:"
    puts "systemctl start sys_watchdog"

    puts "\nTo check daemon status:"
    puts "systemctl status sys_watchdog"
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