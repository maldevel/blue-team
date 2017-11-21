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
echo -e "\e[1;95m-------------------------[banners audit in progress]-------------------------"

fileowner=$(ls -l /etc/motd| awk '{ print $3 }'|grep -c root)
if [ $fileowner -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking /etc/motd owner\t\t\t\t\t\t\t\t$status"

filegroup=$(ls -l /etc/motd| awk '{ print $4 }'|grep -c root)
if [ $filegroup -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking /etc/motd group\t\t\t\t\t\t\t\t$status"

fileperms=$(stat --format '%a' /etc/motd|grep -c 644)
if [ $fileperms -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking /etc/motd file permissions\t\t\t\t\t\t\t$status"

filemessage=$(cat /etc/motd | grep -c "Authorized uses only. All activity may be monitored and reported.")
if [ $filemessage -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking /etc/motd content\t\t\t\t\t\t\t\t$status"

fileowner=$(ls -l /etc/issue| awk '{ print $3 }'|grep -c root)
if [ $fileowner -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking /etc/issue owner\t\t\t\t\t\t\t\t$status"

filegroup=$(ls -l /etc/issue| awk '{ print $4 }'|grep -c root)
if [ $filegroup -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking /etc/issue group\t\t\t\t\t\t\t\t$status"

fileperms=$(stat --format '%a' /etc/issue|grep -c 644)
if [ $fileperms -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking /etc/issue file permissions\t\t\t\t\t\t$status"

filemessage=$(cat /etc/issue | grep -c "Authorized uses only. All activity may be monitored and reported.")
if [ $filemessage -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking /etc/issue content\t\t\t\t\t\t\t\t$status"

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
echo -e "\e[39m[*] Checking /etc/issue.net content\t\t\t\t\t\t\t$status"

echo -e "\033[0m"

