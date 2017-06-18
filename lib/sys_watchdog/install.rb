
# http://rustamagasanov.com/blog/2017/02/24/systemd-example-for-a-simple-ruby-daemon-supervision/
# http://www.devdungeon.com/content/creating-systemd-service-files

# $ vim /lib/systemd/system/allgreen.service
# [Unit]
# Description=Allgreen supervisor
# [Service]
# User=root
# Group=root
# WorkingDirectory=/var/local/allgreen
# Restart=on-failure
# ExecStart=/usr/local/sbin/allgreen.rb

# systemctl enable allgreen
# systemctl start allgreen
# systemctl status allgreen

class Install
  def self.install
    
  end
end