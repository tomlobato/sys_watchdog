Gem::Specification.new do |s|
  s.name          = "sys_watchdog"
  s.version       = "0.0.1"
  s.authors       = ["Tom Lobato"]
  s.email         = "lobato@bettercall.io"
  s.homepage      = "http://rubygems.org/gems/sys_watchdog"
  s.summary       = "SysWatchdog keeps your UNIX servers green by performing periodic checks and opitionaly actions and notifications"
  s.description   = "SysWatchdog keeps your UNIX servers green by performing periodic checks and opitionaly actions and notifications."
  s.licenses      = ["MIT"]
  s.platform      = Gem::Platform::RUBY

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- test/*`.split("\n")
  s.require_paths = ["lib"]
  s.executables   = %w(sys_watchdog)
  s.required_ruby_version = '>= 2.1.0'

  s.add_dependency("mail", "~> 2.5")
  s.add_dependency("slack-ruby-client", "~> 0.8.1")
end

