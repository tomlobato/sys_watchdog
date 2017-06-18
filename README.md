
Sys Watchdog
=================

## Installation

```
gem install sys_watchdog
```

If using Rbenv:

```
rbenv rehash
```

## Setup

If on Linux with systemd available (eg: Ubuntu 16):  

```
sys_watchdog install
```

Otherwise it can run via cron:  

```
echo '* *   * * * root sys_watchdog' >> /etc/crontab
```

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
