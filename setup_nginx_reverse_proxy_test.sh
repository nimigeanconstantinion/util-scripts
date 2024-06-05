#!/bin/bash

# Ensure the script is run as root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# Step 1: Remove NGINX
echo "Removing NGINX..."
yum remove -y nginx

# Step 2: Install NGINX
echo "Installing NGINX..."
yum install -y nginx

# Step 3: Remove the default NGINX configuration
echo "Removing default NGINX configuration..."
rm -f /etc/nginx/conf.d/default.conf
rm -f /etc/nginx/sites-enabled/default

# Step 4: Create new NGINX configuration to redirect to localhost:8080
echo "Configuring NGINX for redirect..."
cat > /etc/nginx/conf.d/redirect.conf <<EOF
server {
    listen       80;
    server_name  localhost;

    location / {
        rewrite ^/(.*)$ http://localhost:5000/ui/$1 permanent;
        
    }
}
EOF

# Step 5: Restart NGINX to apply the changes
echo "Restarting NGINX..."
systemctl restart nginx

echo "NGINX has been reinstalled and configured for redirect."