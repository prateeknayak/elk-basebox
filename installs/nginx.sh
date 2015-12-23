#!/bin/bash

# now lets get nginx to use kibana
sudo apt-get install -y nginx apache2-utils

# permissions and all ya 
sudo htpasswd -b -c /etc/nginx/htpasswd.users kibanaadmin elk123
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
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;        
    }
}
EOL'

sudo chown -R www-data:www-data /var/log/nginx
sudo chmod -R 755 /var/log/nginx
# lets restart nginx
sudo service nginx restart