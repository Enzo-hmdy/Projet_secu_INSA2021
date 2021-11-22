# Documentation Technique

## Liste package necessaire :



## Service utilisés :
<br>

1. ### MariaDB 10.5.12

    1. Fichier Configuration

Fichier configuration  /etc/mysql/mariadb.conf.d/50-server.cnf Modifier la ligne 

```s
bind-address            = 127.0.0.1
```

en 

```s
bind-address           = 0.0.0.0
```

2. ### Configuration du pare-feu 
```bash
ufw allow from 0.0.0.0 to any port 3306 >> /tmp/install.log

iptables -A INPUT -p tcp --dport 3306 -j ACCEPT >> /tmp/install.log

iptables -I INPUT -p tcp --dport 3306 -i eth0 -m state --state NEW -m recent --set >> /tmp/install.log

iptables -I INPUT -p tcp --dport 3306 -i eth0 -m state --state NEW -m recent  --update --seconds 300 --hitcount 4 -j DROP  >> /tmp/install.log

```

3. ### Script python Stegano

```py
"""
This programs aims to convert insert in a png or jpeg file a message using lsg of each byte

usage python3 encrypt input_file output_file message


"""

from os import putenv
from PIL import Image
import numpy as np
import sys
import hashlib


def convert_msg_to_binary(msg):
    """ convert a string in

    Args:
        msg ([type]): [description]

    Returns:
        [type]: [description]
    """

    return ''.join(["{:08b}".format(ord(x)) for x in msg])


def hashage(msg):
    hash = hashlib.sha1(msg.encode())
    hex_hash = hash.hexdigest()
    print(hex_hash)
    return hex_hash


def stegano(input_file, output_file, msg):

    img = Image.open(input_file)
    bin_msg = convert_msg_to_binary(msg)
    print(bin_msg)
    bin_msg_lenght = len(convert_msg_to_binary(msg))
    width, height = img.size
    img_data = np.array(img)
    img_data = np.reshape(img_data, width*height*4)
    print(img_data)
    # data[:b_message_lenght] = data[:b_message_lenght] & ~1 | b_message

    for i in range(len(bin_msg)):

        if(bin_msg[i] and not img_data[i] % 2):
            img_data[i] = img_data[i] - 1
        if((bin_msg[i] == '0') and (img_data[i] % 2)):
            img_data[i] = img_data[i] - 1

    img_data = np.reshape(img_data, (height, width, 4))

    new_img = Image.fromarray(img_data)
    new_img.save(output_file)


def main(argv):
    message = ""
    msh_lenght = len(argv) - 3
    for i in range(3, len(argv)):
        message = message + argv[i]
    print("message : ", message)
    stegano(argv[1], argv[2], hashage(message))


if __name__ == "__main__":
    main(sys.argv)

```

* ### Instalation MariaDb en script (Utilisation de Except)

```shell
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


```



