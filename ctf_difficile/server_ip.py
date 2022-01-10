import socket
import time
import os

socket1 = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
socket1.bind(('', 15555))
role_list = []
ip_list = []

s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
s.connect(("8.8.8.8", 80))
own_IP = s.getsockname()[0]
role_list.append("server :"+ own_IP)

while True:
        socket1.listen(5)
        client, address = socket1.accept()
        print "{} connected".format( address )

        response = client.recv(255)
        if response != "":
                print response
                role_list.append(response)
                ip_list.append(response.split(":")[1])
                print("role_list :",role_list,"   ip_list",ip_list)
        if (len(role_list) == 5) : 
            break

print "Close"
client.close()
socket1.close()

time.sleep(15)

print("--------------------sending part-------------------")
role_str = ''.join([str(item.split(":")[0])+"\n"+str(item.split(":")[1])+"\n" for item in role_list])

port = 15556
print("socket part")
socket_list = []
i = 0

for ip in ip_list : 
    socket_list.append(socket.socket(socket.AF_INET, socket.SOCK_STREAM))
    try :
        socket_list[i].connect((ip, port))
        print "Connection on {}".format(port)
        socket_list[i].send(role_str)
        print("SUCCESS : send to "+ip)
        ip_server = ip
    except socket.error as msg:
        print "Socket Error on " + ip + ": %s" % msg
    i+=1
    
print "Close"
os.system("echo \""+role_str+"\"> /home/debian/ip_network.txt")
while (i > 0) :
    i-=1
    socket_list[i].close()