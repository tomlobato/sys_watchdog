require 'test/unit'
require 'sys_watchdog'

class SysWatchdogTest < Test::Unit::TestCase
  def test_run
    conf_file = File.join File.dirname(__FILE__), 'sys_watchdog_test.yml'
    sw = SysWatchdog.new conf_file: conf_file, log_file: STDOUT
    sw.run once: true
  end
end
