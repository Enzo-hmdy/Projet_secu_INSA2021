import socket

socket1 = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
socket1.bind(('', 15555))
role_list = []
ip_list = []

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

print("--------------------sending part-------------------")
ip_str = ''.join([str(item)+"," for item in ip_list])

port = 15555
print("socket part")
socket_list = []
i = 0

s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
s.connect(("8.8.8.8", 80))
own_IP = s.getsockname()[0]
for ip in ip_list : 
    socket_list.append(socket.socket(socket.AF_INET, socket.SOCK_STREAM))
    try :
        socket_list[i].connect((ip, port))
        print "Connection on {}".format(port)
        socket_list[i].send(ip_str)
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