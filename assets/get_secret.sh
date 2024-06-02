#!/bin/bash
exec > /var/log/user-data.log 2>&1
set -x

sudo apt update -y
sudo apt install -y nginx mysql-server awscli jq

sudo systemctl start nginx
sudo systemctl enable nginx

aws configure set region eu-west-1

SECRET_VALUE=$(aws secretsmanager get-secret-value --secret-id mysql-credentials --query SecretString --output text --region eu-west-1)
if [ -z "$SECRET_VALUE" ]; then
    echo "Failed to retrieve secret value" | sudo tee /var/www/html/index.html
else
    echo "Secret value retrieved successfully" >> /var/log/user-data.log

    USERNAME=$(echo $SECRET_VALUE | jq -r '.username')
    PASSWORD=$(echo $SECRET_VALUE | jq -r '.password')

    if [ -z "$USERNAME" ] || [ -z "$PASSWORD" ]; then
        echo "Failed to extract username or password from secret" | sudo tee /var/www/html/index.html
        exit 1
    fi

    sudo systemctl start mysql
    sudo systemctl enable mysql

    # Configure MySQL
    sudo mysql --user=root --execute="ALTER USER 'root'@'localhost' IDENTIFIED WITH 'mysql_native_password' BY '${PASSWORD}';"
    sudo mysql --user=root --password="${PASSWORD}" --execute="FLUSH PRIVILEGES;"
    sudo mysql --user=root --password="${PASSWORD}" --execute="CREATE USER '${USERNAME}'@'%' IDENTIFIED BY '${PASSWORD}';"
    sudo mysql --user=root --password="${PASSWORD}" --execute="GRANT ALL PRIVILEGES ON *.* TO '${USERNAME}'@'%' WITH GRANT OPTION;"
    sudo mysql --user=root --password="${PASSWORD}" --execute="FLUSH PRIVILEGES;"
    
    sudo sed -i "s/bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf
    sudo systemctl restart mysql

    # Verify the user was created and output the results
    MYSQL_USER_INFO=$(sudo mysql --user="{$USERNAME}" --password="${PASSWORD}" --execute="SELECT User, Host FROM mysql.user WHERE User = '${USERNAME}';")
    echo "<h2>MySQL User Info:</h2><pre>${MYSQL_USER_INFO}</pre>" | sudo tee /var/www/html/index.html
fi

# Restart Nginx to serve the new file
sudo systemctl restart nginx