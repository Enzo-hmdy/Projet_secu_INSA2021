sudo apt-get update
apt-get install expect
sudo apt -y install mariadb-server mariadb-client
MYSQL_ROOT_PASSWORD=azerty
MYSQL_INSTAL=$(expect -c "

set timeout 5
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
send \"n\r\"
expect \"Remove test database and access to it?\"
send \"y\r\"
expect \"Reload privilege tables now?\"
send \"y\r\"
expect eof
")

echo "$MYSQL_INSTAL"
ufw allow from 0.0.0.0 to any port 3306
iptables -A INPUT -p tcp --dport 3306 -j ACCEPT
service iptables save
mysql -u root -p$MYSQL_ROOT_PASSWORD -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root';"
sed -i -e 's/127.0.0.1/0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf 
systemctl restart mysql
systemctl restart mariadb
MYMSG=$(cat /proc/sys/kernel/random/uuid | sed 's/[-]//g' | head -c 6; echo;)
sudo apt install fail2ban -y
touch /etc/fail2ban/jail.d/mariadb.conf
echo '[mysqld-auth]
enabled = true
filter   = mysqld-auth
port     = 3306
maxretry = 3
bantime = 600
logpath  = /var/log/mariadb/mariadb.log' >> /etc/fail2ban/jail.d/mariadb.conf