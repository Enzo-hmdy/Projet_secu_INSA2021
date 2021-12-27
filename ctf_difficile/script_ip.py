import socket
import subprocess
# import os 

#récuper sa propre addresse IP
s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
s.connect(("8.8.8.8", 80))
own_IP = s.getsockname()[0]
print(own_IP)

#récuperer les IP du caches ARP
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
        ip_list.append(ip_addr)
    pointer += 1
print(ip_list)
            
# -------- ID d'execution de commande linux --------
#os.system('')
# output = subprocess.Popen(['ls', '-l'], stdout=subprocess.PIPE).communicate()[0]
