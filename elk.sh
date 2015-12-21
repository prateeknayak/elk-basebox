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


# now lets get nginx to use kibana
sudo apt-get install -y nginx apache2-utils

# permissions and all ya 
echo elk123 | sudo htpasswd -c /etc/nginx/htpasswd.users kibanaadmin --stdin
# echo elk123 | sudo htpasswd -c /etc/nginx/htpasswd.users bling --stdin


# add default config to nginx
sudo bash -c 'cat >/etc/nginx/sites-available/default <<EOL
server {
    listen 80;

    server_name kibana.prateeknayak.com;

    auth_basic "Restricted Access";
    auth_basic_user_file /etc/nginx/htpasswd.users;

    location / {
        proxy_pass http://localhost:5601;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;        
    }
}
EOL'

sudo chown -R www-data:www-data /var/log/nginx
sudo chmod -R 755 /var/log/nginx
# lets restart nginx
sudo service nginx restart





