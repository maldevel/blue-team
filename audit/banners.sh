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
echo -e "\e[97m>> banners audit in progress <<"
echo

echo -e "\e[96m>> Checking /etc/motd.."
fileowner=$(ls -l /etc/motd| awk '{ print $3 }'|grep -c root)
if [ $fileowner -eq 0 ];
then
  echo -e "\e[91m/etc/motd is not owned by root..\e[39m"
  #exit
else
  echo -e "\e[92m/etc/motd is owned by root."
fi

filegroup=$(ls -l /etc/motd| awk '{ print $4 }'|grep -c root)
if [ $filegroup -eq 0 ];
then
  echo -e "\e[91m/etc/motd group is not root..\e[39m"
  #exit
else
  echo -e "\e[92m/etc/motd group is root."
fi

fileperms=$(stat --format '%a' /etc/motd|grep -c 644)
if [ $fileperms -eq 0 ];
then
  echo -e "\e[91m/etc/motd permissions are not 644..\e[39m"
  #exit
else
  echo -e "\e[92m/etc/motd permissions are 644."
fi

filemessage=$(cat /etc/motd | grep -c "Authorized uses only. All activity may be monitored and reported.")
if [ $filemessage -eq 0 ];
then
  echo -e "\e[91m/etc/motd message has not been set..\e[39m"
  #exit
else
  echo -e "\e[92m/etc/motd message has been set."
fi

echo 

echo -e "\e[96m>> Checking /etc/issue.."
fileowner=$(ls -l /etc/issue| awk '{ print $3 }'|grep -c root)
if [ $fileowner -eq 0 ];
then
  echo -e "\e[91m/etc/issue is not owned by root..\e[39m"
  #exit
else
  echo -e "\e[92m/etc/issue is owned by root."
fi

filegroup=$(ls -l /etc/issue| awk '{ print $4 }'|grep -c root)
if [ $filegroup -eq 0 ];
then
  echo -e "\e[91m/etc/issue group is not root..\e[39m"
  #exit
else
  echo -e "\e[92m/etc/issue group is root."
fi

fileperms=$(stat --format '%a' /etc/issue|grep -c 644)
if [ $fileperms -eq 0 ];
then
  echo -e "\e[91m/etc/issue permissions are not 644..\e[39m"
  #exit
else
  echo -e "\e[92m/etc/issue permissions are 644."
fi

filemessage=$(cat /etc/issue | grep -c "Authorized uses only. All activity may be monitored and reported.")
if [ $filemessage -eq 0 ];
then
  echo -e "\e[91m/etc/issue message has not been set..\e[39m"
  #exit
else
  echo -e "\e[92m/etc/issue message has been set."
fi

echo 

echo -e "\e[96m>> Checking /etc/issue.net.."
fileowner=$(ls -l /etc/issue.net| awk '{ print $3 }'|grep -c root)
if [ $fileowner -eq 0 ];
then
  echo -e "\e[91m/etc/issue.net is not owned by root..\e[39m"
  #exit
else
  echo -e "\e[92m/etc/issue.net is owned by root."
fi

filegroup=$(ls -l /etc/issue.net| awk '{ print $4 }'|grep -c root)
if [ $filegroup -eq 0 ];
then
  echo -e "\e[91m/etc/issue.net group is not root..\e[39m"
  #exit
else
  echo -e "\e[92m/etc/issue.net group is root."
fi

fileperms=$(stat --format '%a' /etc/issue.net|grep -c 644)
if [ $fileperms -eq 0 ];
then
  echo -e "\e[91m/etc/issue.net permissions are not 644..\e[39m"
  #exit
else
  echo -e "\e[92m/etc/issue.net permissions are 644."
fi

filemessage=$(cat /etc/issue.net | grep -c "Authorized uses only. All activity may be monitored and reported.")
if [ $filemessage -eq 0 ];
then
  echo -e "\e[91m/etc/issue.net message has not been set..\e[39m"
  #exit
else
  echo -e "\e[92m/etc/issue.net message has been set."
fi

echo -e "\e[39m"

