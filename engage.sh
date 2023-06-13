#!/bin/bash
echo "Enter host name, IP address"
#check for correct form using regex, later version

read var_host

echo "*-----------------------------------*"
echo "* 1 - nmap -usual ports"
echo "* 2 - namp -all ports"
echo "* 3 - nmap - UDP ports"
echo "* 4 - gobuster 1"
echo "* 5 - nmap - script vuln scan"
echo "* 6 - Setup directory for engagement"
echo "* 7 - Convert all files into text files"
echo "* 8 - gobuster 2"
echo "* 9 - gobuster 3 - large-files"
echo "* 10 - wfuzz"
echo "*-----------------------------------*"
read var_choice

#check if it is a number, later version

if [ $var_choice = "1" ]
then
  echo "nmap -sC -sV -A "$var_host" -T4"
  sudo nmap -sC -sV -A -oA $var_host"nmap" $var_host -T4
fi
if [ $var_choice = "2" ]
then
  echo "nmap -p- -sC -sV -v -A "$var_host" -T4"
  sudo nmap -p- -sC -sV -v2 -A $var_host -oA $var_host"allportsnmap" -T4
fi
if [ $var_choice = "3" ]
then
  echo "nmap -sU -sV "$var_host
  sudo nmap -sU -sV -oA $var_host"UDPNMAP" $var_host
fi
if [ $var_choice = "4" ]
then
  echo "Directory to search(Enter for current host):"
  read var_dir
  echo "Name of file"
  read file_name
  echo 'gobuster dir -u http://'$var_host$var_dir' -x txt,php,html -w /home/sidejack/Documents/tools/SecLists/Discovery/Web-Content/raft-medium-directories.txt'
  gobuster dir -u http://$var_host$var_dir -x txt,php,html -w /home/sidejack/Documents/tools/SecLists/Discovery/Web-Content/raft-medium-directories.txt -o "GOBUSTER"$file_name".md"
fi
if [ $var_choice = "5" ]
then
  echo "nmap -sV -sC --script='vuln'"$var_host
  sudo nmap -sV -sC --script="vuln" -oA $var_host"vulns" $var_host
fi
if [ $var_choice = "6" ]
then
  echo "Name of target:"
  read targ_name
  mkdir $targ_name
  sudo chmod -R 777 $targ_name
  cd $targ_name
  mkdir exploits scans reports loot
  mkdir scans/nmap
  touch reports/'001 - TD.md' reports/'005 - Enumeration.md' reports/'999 - WID.md'
fi
if [ $var_choice = "7" ]
then
    sudo chmod  777 *
    for i in *.nmap; do mv -- "$i" "${i%.nmap}.md"; done
fi
if [ $var_choice = "8" ]
then
  echo "Directory to search(Enter for current host):"
  read var_dir
  echo "Name of file"
  read file_name
  gobuster dir -u http://$var_host$var_dir -x txt,php,html -w /home/sidejack/Documents/tools/SecLists/Discovery/Web-Content/raft-medium-files-lowercase.txt -o "GOBUSTER"$file_name".md"
fi
if [ $var_choice = "9" ]
then
  echo "Directory to search(Enter for current host):"
  read var_dir
  echo "Name of file"
  read file_name
  gobuster dir -u http://$var_host$var_dir -x txt,php,html -w /home/sidejack/Documents/tools/SecLists/Discovery/Web-Content/raft-large-files.txt -o "GOBUSTER"$file_name".md"
fi
if [ $var_choice = "10" ]
then
  echo "Directory to search(Enter for current host):"
  read var_dir
  echo "Name of file"
  read file_name
  wfuzz -c -z file,/usr/share/wfuzz/wordlist/general/common.txt --hc 404 http://$var_host$var_dir/FUZZ/
fi
