

To get the standard ports and run all the scripts and checks on them: nmap -n -v -sT -A <IP>

To do a full TCP scan: nmap -n -v -sT -p- -T5 <IP>

Then I'll usually run the first one again with -p <any additional ports found>

Then I'll run a "--script vuln" on all the found ports to do an NSE vulnerability scan.

Then if I want to do a UDP scan: nmap -n -v -sU <IP> nmap -n -v -sU -p- -T5 <IP>
