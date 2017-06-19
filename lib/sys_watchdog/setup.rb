
class Setup
  def initialize
    @thisdir = File.join File.dirname(__FILE__)
  end

  def with_systemd
    copy_sample_conf
    install_systemd_service

    puts "Installed."

    puts "\nEdit #{SysWatchdog::DEFAULT_CONF_FILE} and start:"
    puts "systemctl start sys-watchdog"

    puts "\nTo check daemon status:"
    puts "systemctl status sys-watchdog"
  end

  def with_cron
    copy_sample_conf
    add_cron_line

    puts "Installed."

    puts "\nEdit #{SysWatchdog::DEFAULT_CONF_FILE} and uncomment the cron line added."
  end
  
  private

  def add_cron_line
    run "echo '#* *   * * * root /bin/bash -lc \'sys_watchdog once\' >> /etc/crontab"
  end

  def install_systemd_service
    services_dir = "/lib/systemd/system/"

    if `which systemctl`.empty?
      STDERR.puts "SysWatchdog install requires systemctl. Aborting."
      exit 1
    end

    unless File.exist? services_dir
      STDERR.puts "SysWatchdog install requires dir #{services_dir}. Aborting."
      exit 1
    end
    
    copy "#{@thisdir}/../../util/sys-watchdog.service", 
         services_dir

    run 'systemctl enable sys-watchdog'
  end

  def copy_sample_conf
    copy "#{@thisdir}/../../util/sys_watchdog_sample.yml", 
          SysWatchdog::DEFAULT_CONF_FILE
  end

  def copy from, to, mod = 0600
    puts "Copying #{from} to #{to}..."
    FileUtils.cp from, to
    FileUtils.chmod mod, to
  end

  def run cmd
    puts "Running #{cmd}..."
    system cmd
  end

end