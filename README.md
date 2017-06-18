
Sys Watchdog
=================

## Installation

```
gem install 'sys_watchdog'
```

Then, on linux:  

```
sys_watchdog install
```

## Usage

### Create a New Bot Integration

This is something done in Slack, under [integrations](https://my.slack.com/services). Create a [new bot](https://my.slack.com/services/new/bot), and note its API token.

![](screenshots/register-bot.png)

### Use the API Token

```ruby
Slack.configure do |config|
  config.token = ENV['SLACK_API_TOKEN']
end
```

This sets a global default token. You can also pass a token into the initializer of both `Slack::Web::Client` and `Slack::RealTime::Client` or configure those separately via `Slack::Web::Config.configure` and `Slack::RealTime::Config.configure`. The instance token will be used over the client type token over the global default.

### Global Settings

The following global settings are supported via `Slack.configure`.

setting      | description
-------------|-------------------------------------------------------------------------------------------------
token        | Slack API token.
logger       | An optional logger, defaults to `::Logger.new(STDOUT)` at `Logger::WARN` level.

#### Web Client Options

You can configure the Web client either globally or via the initializer.

```ruby
Slack::Web::Client.config do |config|
  config.user_agent = 'Slack Ruby Client/1.0'
end
```

```ruby
client = Slack::Web::Client.new(user_agent: 'Slack Ruby Client/1.0')
```

The following settings are supported.

setting      | description
-------------|-------------------------------------------------------------------------------------------------
token        | Slack API token.
user_agent   | User-agent, defaults to _Slack Ruby Client/version_.
proxy        | Optional HTTP proxy.
ca_path      | Optional SSL certificates path.
ca_file      | Optional SSL certificates file.
endpoint     | Slack endpoint, default is _https://slack.com/api_.
logger       | Optional `Logger` instance that logs HTTP requests.
timeout      | Optional open/read timeout in seconds.
open_timeout | Optional connection open timeout in seconds.

You can also pass request options, including `timeout` and `open_timeout` into individual calls.

```ruby
client.channels_list(request: { timeout: 180 })
```

## Copyright and License

Copyright (c) 2015-2016, [Daniel Doubrovkine](https://twitter.com/dblockdotorg), [Artsy](https://www.artsy.net) and [Contributors](CHANGELOG.md).

This project is licensed under the [MIT License](LICENSE.md).
