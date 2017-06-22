
class Setup
  SYSTEMD_SERVICES_DIR = "/lib/systemd/system/"
  SYSTEMD_SERVICE_FILE = "#{SYSTEMD_SERVICES_DIR}/sys-watchdog.service"

  def initialize
    @thisdir = File.join File.dirname(__FILE__)
  end

  def setup
    check_root
    copy_sample_conf
    create_working_dir
    install_type = get_install_type
    save_install_type install_type
    case install_type
    when 'systemd'
      install_systemd_service
    when 'cron'
      install_cronjob
    end
    setup_finished_msg
  end

  def start
    case read_install_type
    when 'systemd'
      run 'systemctl start sys-watchdog'
    when 'cron'
      rewrite_cronjob true
    end
  end

  def stop
    case read_install_type
    when 'systemd'
      run 'systemctl stop sys-watchdog'
    when 'cron'
      rewrite_cronjob false
    end
  end

  def uninstall
    stop
    File.delete SysWatchdog::DEFAULT_CONF_FILE
    if File.exist?(SYSTEMD_SERVICE_FILE)
      run 'systemctl disable sys-watchdog'
      File.delete SYSTEMD_SERVICE_FILE
    end
    if File.exist?(SysWatchdog::CRONJOB_PATH)
      File.delete SysWatchdog::CRONJOB_PATH
    end
    FileUtils.rm_rf SysWatchdog::WORKING_DIR
    puts "Uninstall complete."
  end

  private

  def setup_finished_msg
    puts "Installed.\n"
    puts "Now:"
    puts "1) Edit #{SysWatchdog::DEFAULT_CONF_FILE} to customize your system tests. You can run 'sys_watchdog test' to adjust your system tests and get a grasp of the sys_watchdog operation."
    puts "2) After configure your system tests run 'sys_watchdog start'."
  end

  def is_setup?
    File.exist?(SysWatchdog::DEFAULT_CONF_FILE) &&
    (File.exist?(SysWatchdog::CRONJOB_PATH) || File.exist?(SYSTEMD_SERVICE_FILE))
  end

  def has_systemd?
    File.exist?(`which systemctl`.strip) && 
    File.writable?('/lib/systemd/system')
  end

  def rewrite_cronjob enable
    c = File.read SysWatchdog::CRONJOB_PATH
    rep = enable ? '' : '#'
    c.gsub!(/^\s*#\s*/, rep)
    File.write SysWatchdog::CRONJOB_PATH, c
  end
  
  def save_install_type install_type
    File.write SysWatchdog::INSTALL_TYPE_PATH,
               install_type
  end

  def read_install_type
    return unless File.exist? SysWatchdog::INSTALL_TYPE_PATH
    File.read SysWatchdog::INSTALL_TYPE_PATH
  end

  def get_install_type
    has_systemd? ? 'systemd' : 'cron'
  end

  def check_root
    unless Process.uid == 0
      STDERR.puts "Install requires root privileges. Run with sudo or login as root. Aborting."
      exit 1
    end
  end

  def create_working_dir
    FileUtils.mkdir_p SysWatchdog::WORKING_DIR
  end

  def install_cronjob
    File.write SysWatchdog::CRONJOB_PATH, 
               "#* *   * * * root /bin/bash -lc 'sys_watchdog once' >> /etc/crontab"
  end

  def install_systemd_service
    if `which systemctl`.strip.empty?
      STDERR.puts "SysWatchdog install requires systemctl. Aborting."
      exit 1
    end

    unless File.exist? SYSTEMD_SERVICES_DIR
      STDERR.puts "SysWatchdog install requires dir #{SYSTEMD_SERVICES_DIR}. Aborting."
      exit 1
    end
    
    copy "#{@thisdir}/../../util/sys-watchdog.service", 
         SYSTEMD_SERVICE_FILE

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