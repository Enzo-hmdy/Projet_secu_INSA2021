#!/bin/bash

sudo apt-get update >> /tmp/install.log
apt-get -y install expect >> /tmp/install.log
sudo apt -y install mariadb-server mariadb-client  >> /tmp/install.log
MYSQL_ROOT_PASSWORD=azerty  >> /tmp/install.log
MYMSG=$(cat /proc/sys/kernel/random/uuid | sed 's/[-]//g' | head -c 6; echo;) >> /tmp/install.log
MYSQL_INSTAL=$(expect -c "  

set timeout 5
spawn mysql_secure_installation
expect \"Enter current password for root:\"
send \"$MYMSG\r\"
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

ADD_USER=$(expect -c "
spawn adduser user
expect \"New password: \" { send \"azerty\r\" }
expect \"Retype new password: \" {send \"azerty\r\"}
expect \"Full name []: \" {send "\r"}
expect \"Room Number\" { send "\r" }
expect \"Work Phone\" { send "\r" }
expect \"Home Phone\" { send "\r" }
expect \"Other\" { send "\r" }
expect \"Is the information correct?\" {send "Y\r"}


")

echo "$MYSQL_INSTAL" >> /tmp/install.log
echo "$ADD_USER" >> /tmp/install.log
apt-get -y install ufw  >> /tmp/install.log
echo "-----------INSTALL UFW -----------" >> /tmp/install.log
ufw allow from 0.0.0.0 to any port 3306 >> /tmp/install.log
iptables -A INPUT -p tcp --dport 3306 -j ACCEPT >> /tmp/install.log
echo "-----------OPEN PORT SQL -----------" >> /tmp/install.log
service iptables save >> /tmp/install.log
mysql -u root -p$MYMSG -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$MYMSG';" >> /tmp/install.log
sed -i -e 's/127.0.0.1/0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf  >> /tmp/install.log
echo "-----------MODIF MARIADB CNF-----------" >> /tmp/install.log
systemctl restart mysql >> /tmp/install.log
systemctl restart mariadb >> /tmp/install.log
echo "-----------MARIADB RESTART -----------" >> /tmp/install.log
apt-get -y install git >> /tmp/install.log
sudo apt-get update
sudo apt-get -y install python3-pip
python3 -m pip install --upgrade pip

python3 -m pip install Pillow >> /tmp/install.log
python3 -m pip install --upgrade pillow
python3 -m pip install numpy >> /tmp/install.log
echo "-----------INSTALL PYTHON -----------" >> /tmp/install.log


git clone https://github.com/projetsecu/projetsecurite.git /home/debian/ctf/
echo "-----------GIT CLONE -----------" >> /tmp/install.log

chmod 777 /home/debian/ctf/ctf_moyen/encrypt.py
sudo python3 /home/debian/ctf/ctf_moyen/encrypt.py /home/debian/ctf/ctf_moyen/a.png /home/debian/picture.png $MYMSG
echo "-----------ENCRYPT PYTHON-----------" >> /tmp/install.log
chmod -R 777 ctf/
sudo rm -r /home/debian/ctf
echo "-----------RM DIRECTORY-----------" >> /tmp/install.log

iptables -I INPUT -p tcp --dport 3306 -i eth0 -m state --state NEW -m recent --set >> /tmp/install.log
echo "-----------IPTABLES CREATE RULE----------" >> /tmp/install.log

iptables -I INPUT -p tcp --dport 3306 -i eth0 -m state --state NEW -m recent  --update --seconds 300 --hitcount 4 -j DROP  >> /tmp/install.log
echo "-----------IPTABLES SET RULE-----------" >> /tmp/install.log

sudo apt-get install whois
USER_PSWD=$(perl -e 'print crypt("azerty","salt"),"\n"')
adduser -m -p $USER_PSWD user

# A mettre dans le crontab toute les minutes :  echo "il est actuellement" && date +%R 

#TODO
#DELETE ALL LOGS
#PREVENT USER >FROM USING SUDO

CREATE DATABASE IF NOT EXISTS script; # Create database
SHOW DATABASES; # show all databases
use script; # select a database

CREATE TABLE test ( id INT PRIMARY KEY, nom VARCHAR(100)); # Create a table 

INSERT INTO test (id,nom) VALUES (1,"ouioui");
INSERT INTO test (id,nom) VALUES (2,"nonnon");
INSERT INTO test (id,nom) VALUES (3,"peutetre");


DELIMITER | 
CREATE PROCEDURE afficher_test()      
BEGIN
    SELECT id, nom
    FROM test;
END| 

# SET GLOBAL event_scheduler=ON;

# DBMS_SCHEDULER.create_program
# (
# program_name => 'sch_program',
# program_type => 'EXECUTABLE',
# program_action => '/home/debiane/shell.sh',
# number_of_arguments => 0,
# enabled => TRUE,
# comments => 'Test Program'
# );
# end;
# /

# DROP EVENT e_daily;

# delimiter |

# CREATE EVENT e_daily
#     ON SCHEDULE
#       EVERY 20 SECOND
#     COMMENT 'Saves total number of sessions then clears the table each day'
#     DO
#       BEGIN
#         program_action => '/home/debian/shell.sh',
#       END |

# delimiter ;

# DBMS_SCHEDULER.CREATE_JOB (
#     job_name          => 'TEST_SHELL',
#     job_type          => 'EXECUTABLE',
#     job_action        => '/home/debian/shell.sh',
#     start_date        => SYSDATE,
#     --repeat_interval   => 'FREQ=MINUTELY; INTERVAL=1',  
#     enabled           => TRUE,
#     comments          => 'Calling shell script from Oracle' 
#     );

    # Changement de droits :
    chmod -R +u  protected_script/
