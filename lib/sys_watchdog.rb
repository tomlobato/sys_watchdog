#!/usr/bin/env ruby

require "net/https"  
require "uri"
require 'fileutils'
require 'logger'
require 'mail'
require 'net/smtp'
require 'ostruct'
require 'rubygems'
require 'slack-ruby-client'
require 'yaml'

# Core
require 'lib/core_extensions'

# Classes
require 'lib/wd_logger'
require 'lib/wd_test'
require 'lib/install'

# Includes
require 'lib/main'
require 'lib/notify'
require 'lib/util'

class SysWatchdog
    CONF_FILE = '/etc/sys_watchdog.yml'
    LOG_FILE = '/var/log/sys_watchdog.log'
    include Notify
    include Util
    include Main
end

