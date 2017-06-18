#!/usr/bin/env ruby

require "net/https"  
require "uri"
require 'fileutils'
require 'logger'
require 'net/smtp'
require 'ostruct'

require 'slack-ruby-client'
require 'mail'

require 'sys_watchdog/core_extensions'
require 'sys_watchdog/wd_logger'
require 'sys_watchdog/wd_test'
require 'sys_watchdog/install'

class SysWatchdog
    DEFAULT_CONF_FILE = '/etc/sys_watchdog.yml'
    DEFAULT_LOG_FILE  = '/var/log/sys_watchdog.log'
end

require 'sys_watchdog/main'
require 'sys_watchdog/notify'
