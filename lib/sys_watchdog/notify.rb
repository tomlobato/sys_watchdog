class SysWatchdog
    private

    def notify sub, body = ""
        begin
            send_mail sub, body if @conf.smtp_server
        rescue => e
            @logger.error e.desc
        end
        begin
            send_slack_msg "#{sub}\n#{body}" if @conf.slack_token
        rescue => e
            @logger.error e.desc
        end
    end

    def send_slack_msg msg
        slack_client = Slack::Web::Client.new
        slack_client.chat_postMessage(channel: @conf[:slack_channel], text: "[#{server_name}] #{msg}", as_user: true)
    end

    def send_mail sub, body
        @logger.info "Sending email: #{ sub }"

        body ||= ""
        body += append_sys_info
        
        conf_ = @conf

        mail = Mail.new do
          from     conf_.mail_from
          to       conf_.mail_to
          subject  "Watchdog #{conf_.name} [#{server_name}]: #{ sub }"
          body     body
        end

        mail.deliver!
    end

    def server_name
        @conf.server_name || `hostname`.strip
    end

    def append_sys_info
        ret = "\n\n--------------- sys info ---------------"
        %Q(
            ps aux
            df -h
            uptime

        ).split("\n").map(&:strip).compact.reject(&:empty?).each do |cmd|
            cmd_result = `#{ cmd }`
            ret += "\n\n#{ cmd }:\n#{ cmd_result }"
        end
        ret
    end
end