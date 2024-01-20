#!/bin/bash

# 1. Ask the user for the ATTACK_IP
# read -p "Enter the ATTACK_IP: " ATTACK_IP

# 2. Ask the user for the TARGET_IP
read -p "Enter the TARGET_IP: " TARGET_IP

# 3. Export the ATTACK_IP and TARGET_IP to the current terminal session
export ATTACK_IP=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | awk '$2 ~ /^(192\.168\.|172\.(1[6-9]|2[0-9]|3[0-1])\.|10\.)/ {print $2; exit}'
)
export TARGET_IP="$TARGET_IP"

# 4. Add export statements for ATTACK_IP and TARGET_IP to ~/.bashrc
echo "export ATTACK_IP=\"$ATTACK_IP\"" >> ~/.bashrc
echo "export TARGET_IP=\"$TARGET_IP\"" >> ~/.bashrc

# 5. Run nmap and direct output to terminal and basic_nmap.txt
nmap -n -v -sT -A "$TARGET_IP" 2>&1 | tee basic_nmap.txt

# 6. Process basic_nmap.txt and save to TARGET_MACHINE_NAME
TARGET_MACHINE_NAME=$(cat basic_nmap.txt | sed -n 's/^|_http-title: Did not follow redirect to http:\/\/\(.*\)/\1/p' | sed 's/\/$//')

# 7. Add the line TARGET_IP TARGET_MACHINE_NAME to /etc/hosts
if [ -n "$TARGET_MACHINE_NAME" ]; then
    echo "$TARGET_IP $TARGET_MACHINE_NAME" | sudo tee -a /etc/hosts
    echo "export TARGET_MACHINE_NAME=\"$TARGET_MACHINE_NAME\"" >> .bashrc
else
    echo "\$TARGET_MACHINE_NAME is empty. Skipping the operation."
fi

echo "Script completed successfully."
