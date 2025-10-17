#!/bin/bash

HOSTNAME=$1
SERVER_IP=$2

# настройка "server"
if [ "$HOSTNAME" == "server" ]; then
    apt-get update
    apt-get install -y apache2 openssl
    mkdir -p /etc/apache2/ssl
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/apache2/ssl/imyme.local.key -out /etc/apache2/ssl/imyme.local.crt -subj "/C=RU/ST=Moscow/L=Moscow/O=MyOrg/OU=MyUnit/CN=imyme.local"

    cat > /etc/apache2/sites-available/000-default.conf <<EOF
<VirtualHost *:80>
    ServerName imyme.local
    ServerAlias www.imyme.local
    Redirect permanent / https://imyme.local/
</VirtualHost>
EOF

    cat > /etc/apache2/sites-available/imyme.local.conf <<EOF
<VirtualHost *:443>
    ServerName imyme.local
    DocumentRoot /var/www/html

    SSLEngine on
    SSLCertificateFile /etc/apache2/ssl/imyme.local.crt
    SSLCertificateKeyFile /etc/apache2/ssl/imyme.local.key

    <Directory /var/www/html>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>

<VirtualHost *:443>
    ServerName www.imyme.local
    Redirect permanent / https://imyme.local/
</VirtualHost>
EOF

    a2enmod ssl
    a2enmod rewrite
    a2ensite imyme.local.conf
    systemctl restart apache2
    cp /etc/apache2/ssl/imyme.local.crt /vagrant/

# настройка "client"
elif [ "$HOSTNAME" == "client" ]; then
    apt-get update
    apt-get install -y ca-certificates
    cp /vagrant/imyme.local.crt /usr/local/share/ca-certificates/
    update-ca-certificates
fi
