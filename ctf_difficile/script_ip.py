import socket
import subprocess
import os

s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
s.connect(("8.8.8.8", 80))
own_IP = s.getsockname()[0]

os.system('sudo apt install nmap -y')
os.system('nmap -sn 172.10.0.0-255')

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
            
