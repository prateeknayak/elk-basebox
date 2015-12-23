#!/bin/bash


# add the elastic GPG key 
wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -

# add to sources
echo "deb http://packages.elastic.co/elasticsearch/2.x/debian stable main" | sudo tee -a /etc/apt/sources.list.d/elasticsearch-2.x.list

# now update
sudo apt-get update

# install elasticsearch 
sudo apt-get -y install elasticsearch

sudo bash -c 'cat >/etc/elasticsearch/elasticsearch.yml<<EOL
network.host: localhost
EOL'

# restart elastic search 
sudo service elasticsearch restart

# configure elastic search on boot
sudo update-rc.d elasticsearch defaults 95 10