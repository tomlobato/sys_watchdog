#!/usr/bin/env ruby

require "net/https"  
require "uri"
require 'fileutils'
require 'logger'
require 'net/smtp'
require 'ostruct'

require 'slack-ruby-client'
require 'mail'

# Core
require 'sys_watchdog/core_extensions'

# Classes
require 'sys_watchdog/wd_logger'
require 'sys_watchdog/wd_test'
require 'sys_watchdog/install'

# Includes
require 'sys_watchdog/main'
require 'sys_watchdog/notify'
require 'sys_watchdog/util'

class SysWatchdog
    CONF_FILE = '/etc/sys_watchdog.yml'
    LOG_FILE  = '/var/log/sys_watchdog.log'
    include Notify
    include Util
    include Main
end

