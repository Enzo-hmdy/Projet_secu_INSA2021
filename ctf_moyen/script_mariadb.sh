sudo apt-get update
apt-get install expect
sudo apt -y install mariadb-server mariadb-client
MYSQL_ROOT_PASSWORD=azerty
MYSQL_INSTAL=$(expect -c "

set timeout 10
spawn mysql_secure_installation
expect \"Enter current password for root:\"
send \"$MYSQL_ROOT_PASSWORD\r\"
expect \"Would you like to setup VALIDATE PASSWORD plugin?\"
send \"n\r\" 
expect \"Change the password for root ?\"
send \"n\r\"
expect \"Remove anonymous users?\"
send \"y\r\"
expect \"Disallow root login remotely?\"
send \"y\r\"
expect \"Remove test database and access to it?\"
send \"y\r\"
expect \"Reload privilege tables now?\"
send \"y\r\"
expect eof
")

echo "$MYSQL_INSTAL"