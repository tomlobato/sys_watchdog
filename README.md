sys_watchdog
=================

[![Gem Version](https://badge.fury.io/rb/sys_watchdog.svg)](https://badge.fury.io/rb/sys_watchdog)
[![Code Climate](https://codeclimate.com/github/tomlobato/sys_watchdog.svg)](https://codeclimate.com/github/tomlobato/sys_watchdog)
![](http://ruby-gem-downloads-badge.herokuapp.com/sys_watchdog?type=total&label=gem%20downloads)
 
By [Bettercall.io](https://bettercall.io/).

sys_watchdog keeps your *NIX servers green by performing periodic checks and optionally actions like service restarts and notifications.  

Take 20min to install and start to think what you\`ll make with your spare time ;)

## Install

**Perform this and following steps logged as root user.**

```
gem install sys_watchdog
```

If using Rbenv, run ```rbenv rehash``` to make sys_watchdog binary available.

## Setup

If on Linux with systemd available (eg: Ubuntu 16+, RedHat 7+. Generally distro versions released from 2015 on):  

```
sys_watchdog setup_with_systemd
```

Otherwise:  

```
sys_watchdog setup_with_cron
```

Edit ```/etc/sys_watchdog.yml```. You can see example configurations in [util/sys_watchdog_sample.yml](https://github.com/tomlobato/sys_watchdog/blob/master/util/sys_watchdog_sample.yml) and [test/sys_watchdog_test.yml](https://github.com/tomlobato/sys_watchdog/blob/master/test/sys_watchdog_test.yml).  

## Test run

Run from command line:

```
sys_watchdog test
``` 

It will execute all system tests defined in ```/etc/sys_watchdog.yml``` and exit. You can use this to adjust your tests and get a grasp of the sys_watchdog operation.  

## Start

Finally, start the periodic run...

for systemd:  

```systemctl start sys_watchdog```

or, if installed with cron, uncomment the cron job line:  

```vim /etc/crontab```

## Command line Cli

```
# sys_watchdog help
sys_watchdog v0.1.13

Usage: sys_watchdog [setup|test|start|stop|once|uninstall|help|version]

When called without options executes the system tests each 60 seconds. This is the normal operation when working with a system daemon starter like systemd or upstart.

Options:
  setup        Create the configuration file, create the working directory and configure periodic run with systemd or cron.
  test         Similar to once, but also sets the log output to STDOUT.
  start        Start periodic run. If using systemd it will run 'systemctl start sys_watchdog'. If using cron it will enable/uncomment the cronjob line.  
  stop         Stop periodic run.
  once         Run tests once and exit, rather than run each 60 seconds which is the normal behavior.
  uninstall    Deletes created files and services. After that, if you want to completlly uninstall, run 'gem uninstall sys_watchdog'.
  -v, version  Prints version and exit.
  -h, help     Prints the current message.
```

## Config Settings

setting      | description
-------------|-------------------------------------------------------------------------------------------------
name         | -
server_name  | -
slack_token  | -
slack_channel| -
smtp_server  | -
smtp_domain  | -
mail_from    | -
mail_to      | -

## Sys Test Settings

setting           | description
------------------|-------------------------------------------------------------------------------------------
test_cmd                 | -
test_url                 | -
notify_on_output_change  | -
restore_cmd              | -
expected_regex           | -
expected_string          | -
expected_max             | -
expected_min             | -

## Create a Slack Token

From https://github.com/slack-ruby/slack-ruby-client ...  

This is something done in Slack, under [integrations](https://my.slack.com/services). Create a [new bot](https://my.slack.com/services/new/bot), and note its API token.

![](images/register-bot.png)

## Develop

**Don\`t need root privileges here.**

Download & install dependencies:  

```
git clone https://github.com/tomlobato/sys_watchdog
cd sys_watchdog
bundle
```

Run code tests:  

```
chmod 0600 test/sys_watchdog_test.yml 
rake test
```

Run sys_watchdog tests:

```
./bin/sys_watchdog test
```

Send a PR and win a merge! Its free ;)

## Copyright and License

Copyright (c) 2017, [Bettercall.io](https://bettercall.io).

This project is licensed under the MIT License.
