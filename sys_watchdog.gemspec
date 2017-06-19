Gem::Specification.new do |s|
  s.name          = "sys_watchdog"
  s.version       = "0.1.2"
  s.authors       = ["Tom Lobato"]
  s.email         = "lobato@bettercall.io"
  s.homepage      = "http://sys-watchdog.bettercall.io/"
  s.summary       = "SysWatchdog keeps your *NIX servers green by performing periodic checks and optionally actions like service restarts and notifications."
  s.description   = "#{s.summary} https://github.com/tomlobato/sys_watchdog http://sys-watchdog.bettercall.io."
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

