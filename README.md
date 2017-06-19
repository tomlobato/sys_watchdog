
Sys Watchdog
=================

** perform all steps as root

## Install

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
test_cmd          | -
test_url          | -
notify_on_change  | -
restore_cmd       | -
expected_regex    | -
expected_string   | -
expected_max      | -
expected_min      | -

## Create a Slack Token

From https://github.com/slack-ruby/slack-ruby-client ...  

This is something done in Slack, under [integrations](https://my.slack.com/services). Create a [new bot](https://my.slack.com/services/new/bot), and note its API token.

![](screenshots/register-bot.png)

## Copyright and License

Copyright (c) 2017-2016, [Tom Lobato](https://github.com/tomlobato).

This project is licensed under the MIT License.
