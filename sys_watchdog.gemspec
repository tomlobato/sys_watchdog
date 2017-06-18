Gem::Specification.new do |s|
  s.name          = "sys_watchdog"
  s.version       = "0.0.1"
  s.authors       = ["Tom Lobato"]
  s.email         = %q{lobato@bettercall.io}
  s.homepage      = %q{http://rubygems.org/gems/sys_watchdog}
  s.summary       = %q{SysWatchdog keeps your UNIX servers green by performing periodic checks and opitionally actions and notifications}
  s.description   = %q{SysWatchdog keeps your UNIX servers green by performing periodic checks and opitionally actions and notifications}
  s.licenses      = ["MIT"]
  s.platform      = Gem::Platform::RUBY

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- test/*`.split("\n")
  s.require_paths = ["lib"]
  s.required_ruby_version = '>= 1.8.7'
  s.default_executable = "sys_watchdog"
  s.require_paths = ["lib"]

  s.add_dependency("warden", "~> 1.2.3")
  s.add_dependency("orm_adapter", "~> 0.1")
  s.add_dependency("bcrypt", "~> 3.0")
  s.add_dependency("railties", ">= 4.1.0", "< 5.2")
  s.add_dependency("responders")
end

