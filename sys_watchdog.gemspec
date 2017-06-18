Gem::Specification.new do |s|
  s.name               = "sys_watchdog"
  s.version            = "0.0.1"
  s.default_executable = "sys_watchdog"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Bettercall"]
  s.date = %q{2017-06-18}
  s.description = %q{Keep your UNIX servers green by performing periodic checks and opitionally actions and notifications}
  s.email = %q{lobato@bettercall.io}
  s.files = %w(
    Rakefile
    lib/sys_watchdog.rb
    lib/sys_watchdog/core_extensions.rb
    lib/sys_watchdog/install.rb
    lib/sys_watchdog/main.rb
    lib/sys_watchdog/notify.rb
    lib/sys_watchdog/run.rb
    lib/sys_watchdog/util.rb
    lib/sys_watchdog/wd_logger.rb
    lib/sys_watchdog/wd_test.rb
    bin/sys_watchdog
    util/sys_watchdog.service
    util/sys_watchdog_sample.yml
  )
  s.test_files = ["test/test_sys_watchdog.rb"]
  s.homepage = %q{http://rubygems.org/gems/sys_watchdog}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{2.5.1}
  s.summary = %q{sys_watchdog}
  s.license = 'MIT'

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

