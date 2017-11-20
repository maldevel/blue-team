#!/bin/bash

#    This file is part of blue-team
#    Copyright (C) 2017 @maldevel
#    https://github.com/maldevel/blue-team
#    
#    blue-team - Blue Team Scripts.
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#   
#    For more see the file 'LICENSE' for copying permission.



echo
echo -e "\e[1;95m-------------------------[ssh audit in progress]-------------------------"


fileowner=$(ls -l /etc/ssh/sshd_config| awk '{ print $3 }'|grep -c root)
if [ $fileowner -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking /etc/ssh/sshd_config owner\t\t\t\t\t\t\t$status"

filegroup=$(ls -l /etc/ssh/sshd_config| awk '{ print $4 }'|grep -c root)
if [ $filegroup -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking /etc/ssh/sshd_config group\t\t\t\t\t\t\t$status"

fileperms=$(stat --format '%a' /etc/ssh/sshd_config|grep -c 600)
if [ $fileperms -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking /etc/ssh/sshd_config file permissions\t\t\t\t\t$status"

signature=$(grep -cP '^Port 62111$' /etc/ssh/sshd_config)
if [ $signature -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking if port has been changed\t\t\t\t\t\t\t$status"

signature=$(grep -cP '^Protocol 2$' /etc/ssh/sshd_config)
if [ $signature -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking if Protocol 2 is enabled\t\t\t\t\t\t\t$status"

signature=$(grep -cP '^LogLevel INFO$' /etc/ssh/sshd_config)
if [ $signature -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking if LogLevel is set to INFO\t\t\t\t\t\t\t$status"

signature=$(grep -cP '^MaxAuthTries 3$' /etc/ssh/sshd_config)
if [ $signature -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking if MaxAuthTries has been configured\t\t\t\t\t$status"

signature=$(grep -cP '^IgnoreRhosts yes$' /etc/ssh/sshd_config)
if [ $signature -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking if IgnoreRhosts is enabled\t\t\t\t\t\t\t$status"

signature=$(grep -cP '^HostbasedAuthentication\sno$' /etc/ssh/sshd_config)
if [ $signature -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking if HostbasedAuthentication is disabled\t\t\t\t\t$status"

signature=$(grep -cP '^PermitRootLogin\sno$' /etc/ssh/sshd_config)
if [ $signature -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking if root login is enabled\t\t\t\t\t\t\t$status"

signature=$(grep -cP '^PermitEmptyPasswords\sno$' /etc/ssh/sshd_config)
if [ $signature -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking if Empty Passwords are disabled\t\t\t\t\t\t$status"

signature=$(grep -cP '^PermitUserEnvironment\sno$' /etc/ssh/sshd_config)
if [ $signature -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking if users are allowed to set environment options\t\t\t\t$status"

signature=$(grep -cP '^Ciphers aes256-ctr$' /etc/ssh/sshd_config)
if [ $signature -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking if only approved ciphers are allowed\t\t\t\t\t$status"

signature=$(grep -cP '^MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512,hmac-sha2-256$' /etc/ssh/sshd_config)
if [ $signature -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking if MAC has been configured\t\t\t\t\t\t\t$status"

signature=$(grep -cP '^ClientAliveInterval 300$' /etc/ssh/sshd_config)
if [ $signature -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking if ClientAliveInterval has been configured\t\t\t\t\t$status"

signature=$(grep -cP '^ClientAliveCountMax 0$' /etc/ssh/sshd_config)
if [ $signature -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking if ClientAliveCountMax has been configured\t\t\t\t\t$status"

signature=$(grep -cP '^Banner \/etc\/issue\.net$' /etc/ssh/sshd_config)
if [ $signature -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking if Banner has been configured\t\t\t\t\t\t$status"

fileowner=$(ls -l /etc/issue.net| awk '{ print $3 }'|grep -c root)
if [ $fileowner -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking /etc/issue.net owner\t\t\t\t\t\t\t$status"

filegroup=$(ls -l /etc/issue.net| awk '{ print $4 }'|grep -c root)
if [ $filegroup -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking /etc/issue.net group\t\t\t\t\t\t\t$status"

fileperms=$(stat --format '%a' /etc/issue.net|grep -c 644)
if [ $fileperms -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking /etc/issue.net file permissions\t\t\t\t\t\t$status"

filemessage=$(cat /etc/issue.net | grep -c "Authorized uses only. All activity may be monitored and reported.")
if [ $filemessage -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking /etc/issue.net text content\t\t\t\t\t\t$status"

signature=$(grep -cP '^AllowGroups wheel$' /etc/ssh/sshd_config)
if [ $signature -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking if only wheel group is allowed to access ssh\t\t\t\t$status"

signature=$(grep -cP '^#X11Forwarding yes$' /etc/ssh/sshd_config)
if [ $signature -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking if X11 forwarding is disabled\t\t\t\t\t\t$status"

echo -e "\e[39m"

