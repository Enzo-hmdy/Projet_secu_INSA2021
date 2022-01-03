import socket

socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
socket.bind(('', 15555))
role_list = []
ip_list = []

while True:
        socket.listen(5)
        client, address = socket.accept()
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
socket.close()

ip_str = ''.join([str(item)+"," for item in ip_list])