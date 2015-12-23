#!/bin/bash

# install kibana

# create kibana user and group
sudo groupadd kibana
sudo useradd -g kibana kibana

# download kibana 
cd ~; wget https://download.elastic.co/kibana/kibana/kibana-4.3.0-linux-x64.tar.gz

# extract kibana
tar xvf kibana-*.tar.gz

# moving kibana to opt
sudo mkdir -p /opt/kibana
sudo cp -R ~/kibana-4*/* /opt/kibana/

# permissions and all ya
sudo chown -R kibana: /opt/kibana

# download kibana init script
cd /etc/init.d && sudo curl -o kibana https://gist.githubusercontent.com/thisismitch/8b15ac909aed214ad04a/raw/fc5025c3fc499ad8262aff34ba7fde8c87ead7c0/kibana-4.x-init
cd /etc/default && sudo curl -o kibana https://gist.githubusercontent.com/thisismitch/8b15ac909aed214ad04a/raw/fc5025c3fc499ad8262aff34ba7fde8c87ead7c0/kibana-4.x-default


# enable kibana and start
sudo chmod +x /etc/init.d/kibana
sudo update-rc.d kibana defaults 96 9

sudo bash -c 'cat >/opt/kibana/config/kibana.yml<<EOL
server.host: "localhost"
EOL'

sudo service kibana start