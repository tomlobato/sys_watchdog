
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

After install, edit ```/etc/sys_watchdog.yml```.
You can see some examples in this file and in [test/sys_watchdog_test.yml](https://github.com/tomlobato/sys_watchdog/blob/master/test/sys_watchdog_test.yml).  

Now you can test from the command line. 

```
sys_watchdog test
``` 

### Start

Finally, after installed and configured, start the periodic run...

for systemd:  
```systemctl start sys_watchdog```

or, if installed with cron, uncomment the added cron line:  
```vim /etc/crontab```


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
