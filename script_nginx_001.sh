#!/bin/bash

# Check if running as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit 1
fi

# Remove NGINX
echo "Removing NGINX..."
yum remove -y nginx

# Install NGINX
echo "Installing NGINX..."
yum install -y nginx

# Remove default NGINX configurations
echo "Removing default NGINX configuration..."
rm -f /etc/nginx/nginx.conf
rm -f /etc/nginx/conf.d/default.conf
rm -f /etc/nginx/sites-enabled/default

# Configure NGINX to redirect to localhost:5000 and respond to IP 34.247.255.42
echo "Configuring NGINX for redirect..."
cat > /etc/nginx/nginx.conf <<EOF
user nginx;
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /run/nginx.pid;

include /usr/share/nginx/modules/*.conf;

events {
    worker_connections 1024;
}

http {
    log_format  main  '\$remote_addr - \$remote_user [\$time_local] "\$request" '
                      '\$status \$body_bytes_sent "\$http_referer" '
                      '"\$http_user_agent" "\$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;

    sendfile            on;
    tcp_nopush          on;
    tcp_nodelay         on;
    keepalive_timeout   65;
    types_hash_max_size 2048;

    include             /etc/nginx/mime.types;
    default_type        application/octet-stream;

    include /etc/nginx/conf.d/*.conf;

    server {
        listen       80 default_server;
        server_name  34.247.255.42;

        location / {
            proxy_pass http://localhost:5000;
            proxy_set_header Host \$host;
            proxy_set_header X-Real-IP \$remote_addr;
            proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto \$scheme;
        }
    }
}
EOF

# Restart NGINX to apply the changes
echo "Restarting NGINX..."
systemctl restart nginx

# Check if NGINX restarted successfully
if ! systemctl is-active --quiet nginx; then
  echo "NGINX failed to start. Please check the configuration and error logs."
  exit 1
fi

echo "NGINX has been reinstalled and configured for redirect."