#!/bin/bash
exec > /home/ubuntu/user-data.log 2>&1
set -x

sudo apt update -y
sudo apt install -y nginx mysql-server jq unzip

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm -rf awscliv2.zip aws

sudo systemctl start nginx
sudo systemctl enable nginx

aws configure set region eu-west-1

# Retrieve secret value from AWS Secrets Manager
SECRET_VALUE=$(aws secretsmanager get-secret-value --secret-id peex1-credentials --query SecretString --output text --region eu-west-1)
if [ -z "$SECRET_VALUE" ]; then
    echo "Failed to retrieve secret value" | sudo tee /var/www/html/index.html
    exit 1
else
    echo "Secret value retrieved successfully" >> /home/ubuntu/user-data.log

    # Extract username and password from the secret value
    USERNAME=$(echo $SECRET_VALUE | jq -r '.username')
    PASSWORD=$(echo $SECRET_VALUE | jq -r '.password')

    echo "Retrieved Username: $USERNAME" >> /home/ubuntu/user-data.log
    echo "Retrieved Password: $PASSWORD" >> /home/ubuntu/user-data.log

    if [ -z "$USERNAME" ] || [ -z "$PASSWORD" ]; then
        echo "Failed to extract username or password from secret" | sudo tee /var/www/html/index.html
        exit 1
    fi

    # Start and enable MySQL
    sudo systemctl start mysql
    sudo systemctl enable mysql

    # Wait for MySQL to be fully ready
    while ! sudo mysqladmin ping --silent; do
        echo "Waiting for MySQL to be up..."
        sleep 2
    done

    # Create a MySQL script file
    cat <<EOF > /tmp/mysql-commands.sql
ALTER USER 'root'@'localhost' IDENTIFIED WITH 'mysql_native_password' BY '${PASSWORD}';
FLUSH PRIVILEGES;
CREATE USER '${USERNAME}'@'%' IDENTIFIED BY '${PASSWORD}';
GRANT ALL PRIVILEGES ON *.* TO '${USERNAME}'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF

    # Execute the MySQL script file
    sudo mysql --user=root < /tmp/mysql-commands.sql

    # Clean up the MySQL script file
    rm /tmp/mysql-commands.sql

    # Update MySQL configuration to allow remote connections
    sudo sed -i "s/bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf
    sudo systemctl restart mysql

    # Verify the user was created and log in with it
    MYSQL_USER_INFO=$(sudo mysql --user="${USERNAME}" --password="${PASSWORD}" --execute="SELECT User, Host FROM mysql.user WHERE User = '${USERNAME}';")
    echo "MySQL User Info: ${MYSQL_USER_INFO}" >> /home/ubuntu/user-data.log

    if [[ "$MYSQL_USER_INFO" == *"${USERNAME}"* ]]; then
        echo "<h2>MySQL User '${USERNAME}' Created Successfully</h2>" | sudo tee /var/www/html/index.html
        echo "<p>Successfully logged in with MySQL user '${USERNAME}'.</p>" | sudo tee -a /var/www/html/index.html
        echo "<pre>${MYSQL_USER_INFO}</pre>" | sudo tee -a /var/www/html/index.html
    else
        echo "<h2>Failed to Create MySQL User '${USERNAME}'</h2>" | sudo tee /var/www/html/index.html
    fi
fi

# Restart Nginx to serve the new file
sudo systemctl restart nginx