import socket
import subprocess
import os
import time

hote = "localhost"
port = 15555

s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
s.connect(("8.8.8.8", 80))
own_IP = s.getsockname()[0]

os.system('sudo apt install nmap -y')
os.system('nmap -sn 172.10.0.0-255')

time.sleep(5)

output = subprocess.check_output("sudo arp -a", shell=True)
ip_list = []
pointer = 0
while pointer < len(output) : 
    if output[pointer] == '(':
        i = 1
        ip_addr = ""
        while ( output[pointer+i] != ')'):
            ip_addr = ip_addr + str(output[pointer+i])
            i+=1
        pointer = pointer + i
        if output[pointer+5] != '<' :
            ip_list.append(ip_addr)
    pointer += 1

print("own IP : ",own_IP)
print("IP list: ",ip_list)
ip_str = ''.join([str(item)+"," for item in ip_list])

print("socket part")
socket_list = []
i = 0
for ip in ip_list : 
    socket_list.append(socket.socket(socket.AF_INET, socket.SOCK_STREAM))
    try :
        socket_list[i].connect((ip, port))
        print "Connection on {}".format(port)
        socket_list[i].send( "role :"+ own_IP)
        print("SUCCESS : send to "+ip)
        ip_server = ip
        break
    except socket.error as msg:
        print "Socket Error on " + ip + ": %s" % msg
    i+=1
    
print "Close"
while (i > 0) :
    i-=1
    socket_list[i].close()
    
print "Recev part"
socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
socket.bind(('', 15555))

while True:
        socket.listen(5)
        client, address = socket.accept()
        print "{} connected".format( address )

        response = client.recv(255)
        if response != "":
                print response


print "Close"
client.close()
socket.close()