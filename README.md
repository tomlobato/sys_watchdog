
Sys Watchdog
=================

## Installation

```
gem install sys_watchdog
```

If using Rbenv, run ```rbenv rehash``` to make sys_watchdog binary available.

## Setup

If on Linux with systemd available (eg: Ubuntu 16+, RedHat 7+. Generally distro versions released from 2015):  

```
sys_watchdog setup_with_systemd
```

Otherwise:  

```
sys_watchdog setup_with_cron
```

### Configuration

After install, edit ```/etc/sys_watchdog.yml```. It has some examples of tests.  
Beside /etc/sys_watchdog.yml, you can tak a look in [/test/sys_watchdog_test.yml](https://github.com/tomlobato/sys_watchdog/blob/master/test/sys_watchdog_test.yml) to see examples.  
If instaled via cron, uncomment the job line in /etc/crontab.

### Config Settings

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

#### Sys Test Settings

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
