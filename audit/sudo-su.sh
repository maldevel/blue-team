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
echo -e "\e[1;95m-------------------------[sudo/su audit in progress]-------------------------"

installed=$(dpkg-query -W -f='${Status}' sudo 2>/dev/null | grep -c "ok installed")
if [ $installed -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking sudo installation\t\t\t\t\t\t\t\t$status"

groupwheel=$(getent group wheel 2>/dev/null | grep -c "wheel")
if [ $groupwheel -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking if wheel group exists\t\t\t\t\t\t\t$status"

userexists=$(getent passwd $1 2>/dev/null | grep -c $1)
if [ $userexists -eq 0 ];
then
  status="\e[91m[ BAD ]"
  echo -e "\e[39m[*] Checking if user exists\t\t\t\t\t\t\t\t$status\e[39m"
else
  status="\e[92m[ GOOD ]"
  echo -e "\e[39m[*] Checking if user exists\t\t\t\t\t\t\t\t$status\e[39m"
  
  userwheel=$(groups $1|grep -c "\bwheel\b")
  if [ $userwheel -eq 0 ];
  then
    status="\e[91m[ BAD ]"
    #exit
  else
    status="\e[92m[ GOOD ]"
  fi
echo -e "\e[39m[*] Checking if $1 is in group wheel\t\t\t\t\t\t\t$status"
fi

suwheel=$(grep -cP '^auth\s+required\s+pam_wheel\.so\s+group=wheel\s+debug$' /etc/pam.d/su)
if [ $suwheel -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking if su usage is restricted to wheel group only\t\t\t\t$status"

if [ ! -f /etc/sudoers ]; 
then
  status="\e[91m[ BAD ]"
  echo -e "\e[39m[*] Checking if sudo usage is restricted to wheel group only\t\t\t\t$status\e[39m"
  exit
fi

sudowheel=$(grep -cP '^%wheel\s+ALL=\(ALL:ALL\)\s+ALL$' /etc/sudoers)
if [ $sudowheel -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking if sudo usage is restricted to wheel group only\t\t\t\t$status"

echo -e "\033[0m"

