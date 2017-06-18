
Sys Watchdog
=================

## Installation

```
gem install sys_watchdog
```

Then, on linux:  

```
sys_watchdog install
```

### Config Settings

setting      | description
-------------|-------------------------------------------------------------------------------------------------
name         | Slack API token.
server_name  | An optional logger, defaults to `::Logger.new(STDOUT)` at `Logger::WARN` level.
slack_token  | An optional logger, defaults to `::Logger.new(STDOUT)` at `Logger::WARN` level.
slack_channel| An optional logger, defaults to `::Logger.new(STDOUT)` at `Logger::WARN` level.
smtp_server  | An optional logger, defaults to `::Logger.new(STDOUT)` at `Logger::WARN` level.
smtp_domain  | An optional logger, defaults to `::Logger.new(STDOUT)` at `Logger::WARN` level.
mail_from    | An optional logger, defaults to `::Logger.new(STDOUT)` at `Logger::WARN` level.
mail_to      | An optional logger, defaults to `::Logger.new(STDOUT)` at `Logger::WARN` level.

#### Sys Test Settings

setting           | description
------------------|-------------------------------------------------------------------------------------------
test_cmd          | Slack API token.
test_url          | User-agent, defaults to _Slack Ruby Client/version_.
notify_on_change  | Optional HTTP proxy.
restore_cmd       | Optional SSL certificates path.
expected_regex    | Optional SSL certificates file.
expected_string   | Slack endpoint, default is _https://slack.com/api_.
expected_max      | Optional `Logger` instance that logs HTTP requests.
expected_min      | Optional open/read timeout in seconds.

## Usage

### Create a New Bot Integration

This is something done in Slack, under [integrations](https://my.slack.com/services). Create a [new bot](https://my.slack.com/services/new/bot), and note its API token.

![](screenshots/register-bot.png)

## Copyright and License

Copyright (c) 2017-2016, [Tom Lobato](https://github.com/tomlobato).

This project is licensed under the MIT License.
