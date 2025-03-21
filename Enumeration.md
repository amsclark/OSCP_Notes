Per https://www.reddit.com/user/dw3113r/

```
To get the standard ports and run all the scripts and checks on them: nmap -n -v -sT -A $TARGET_IP

To do a full TCP scan: nmap -n -v -sT -p- -T5 $TARGET_IP
nmap -sC -sV -p- -O -T4 --min-rate=1000 --max-retries=2 --open -oA full_scan <host>


Then I'll usually run the first one again with -p <any additional ports found>

Then I'll run a "--script vuln" on all the found ports to do an NSE vulnerability scan.

Then if I want to do a UDP scan: nmap -n -v -sU <IP> nmap -n -v -sU -p- -T5 $TARGET_IP
```

Then if there is a web server, usually run:
```
dirb <url>
wget https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/directory-list-2.3-medium.txt
wget https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/common.txt
gobuster dir -u http://$TARGET_MACHINE_NAME -w directory-list-2.3-medium.txt -x php,html
feroxbuster --url http://$TARGET_MACHINE_NAME -w common.txt
nikto -h $TARGET_MACHINE_NAME
```
DNS Subdomain Enumeration:
```
wget https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/DNS/subdomains-top1million-20000.txt
gobuster dns -d $TARGET_MACHINE_NAME -w subdomains-top1million-20000.txt -t 20
wfuzz -w subdomains-top1million-2000.txt -u http://$TARGET_MACHINE_NAME/ -H 'Host: FUZZ.$TARGET_MACHINE_NAME' -t 50 --hc 302
```
