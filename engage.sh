#!/bin/bash
echo "Enter host name, IP address"
#check for correct form using regex, later version

read var_host

echo "*-----------------------------------*"
echo "* 1 - nmap -usual ports"
echo "* 2 - namp -all ports"
echo "* 3 - nmap - UDP ports"
echo "* 4 - gobuster"
echo "* 5 - dirbuster"
echo "*-----------------------------------*"
read var_choice

#check if it is a number, later version

if [ $var_choice = "1" ]
then
  sudo nmap -sC -sV -A -v -oA $var_host"nmap" $var_host
fi
if [ $var_choice = "2" ]
then
  sudo nmap -p- $var_host
fi
if [ $var_choice = "3" ]
then
  sudo nmap -sU --top-ports 10 -sV -oA $var_host"UDPNMAP" $var_host
fi
if [ $var_choice = "4" ]
then
  echo "Directory to search(Enter for current host):"
  read var_dir
  gobuster dir -u http://$var_host$var_dir -x txt,php,html -w /home/sidejack/Documents/tools/SecLists/Discovery/Web-Content/raft-medium-directories.txt
fi
if [ $var_choice = "5" ]
then
  dirbuster
fi
