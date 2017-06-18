require 'test/unit'
require 'sys_watchdog'

class SysWatchdogTest < Test::Unit::TestCase
  def test_init
    assert_equal SysWatchdog.new, true
  end
end
