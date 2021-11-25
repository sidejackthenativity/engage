#!/bin/bash
echo "Enter host name, IP address"
#check for correct form using regex, later version

read var_host

echo "*-----------------------------------*"
echo "* 1 - nmap -usual ports"
echo "* 2 - namp -all ports"
echo "* 3 - gobuster"
echo "* 4 - dirbuster"
echo "*-----------------------------------*"
read var_choice

#check if it is a number, later version

if [ $var_choice = "1" ]
then
  nmap -sC -sV -A -v $var_host
fi
if [ $var_choice = "2" ]
then
  nmap -p- $var_host
fi
if [ $var_choice = "3" ]
then
  echo "Directory to search(Enter for current host):"
  read var_dir
  gobuster dir -u http://$var_host$var_dir -w /home/sidejack/Documents/tools/SecLists/Discovery/Web-Content/raft-medium-directories.txt
fi
if [ $var_choice = "4" ]
then
  dirbuster
fi



