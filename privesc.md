LinPeas:
```
https://github.com/carlospolop/PEASS-ng/tree/master/linPEAS
```

Check what low-level user can run as root:
```
sudo -l
```
I have had it happen before that LinPeas / Linux Exploit Suggester don't flag a kernel vuln. So always also do:
```
uname -a
```
And search for any kernel vulns.
