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
echo -e "\e[97m>> sudo/su audit in progress <<"
echo

echo -e "\e[96m>> Checking sudo installation.."
installed=$(dpkg-query -W -f='${Status}' sudo 2>/dev/null | grep -c "ok installed")
if [ $installed -eq 0 ];
then
  echo -e "\e[91msudo is not installed..\e[39m"
  #exit
else
  echo -e "\e[92msudo is already installed."
fi

echo

echo -e "\e[96m>> Checking if wheel group exists.."
groupwheel=$(getent group wheel 2>/dev/null | grep -c "wheel")
if [ $groupwheel -eq 0 ];
then
  echo -e "\e[91mwheel does not exist..\e[39m"
  #exit
else
  echo -e "\e[92mwheel group exists."
fi

echo

echo -e "\e[96m>> Checking if $1 is in group wheel.."
userwheel=$(groups $1|grep -c "\bwheel\b")
if [ $userwheel -eq 0 ];
then
  echo -e "\e[91m$1 is not in group wheel..\e[39m"
  #exit
else
  echo -e "\e[92m$1 is in group wheel."
fi

echo 

echo -e "\e[96m>> Checking if su usage is restricted to wheel group only.."
suwheel=$(grep -cP '^auth\s+required\s+pam_wheel\.so\s+group=wheel\s+debug$' /etc/pam.d/su)
if [ $suwheel -eq 0 ];
then
  echo -e "\e[91msu usage is not restricted to wheel group only..\e[39m"
  #exit
else
  echo -e "\e[92msu usage is restricted to wheel group only."
fi

echo 

echo -e "\e[96m>> Checking if sudo usage is restricted to wheel group only.."
if [ ! -f /etc/sudoers ]; then
  echo -e "\e[91msudo usage is not restricted to wheel group only..\e[39m"
  echo
  exit
fi

sudowheel=$(grep -cP '^%wheel\s+ALL=\(ALL:ALL\)\s+ALL$' /etc/sudoers)
if [ $sudowheel -eq 0 ];
then
  echo -e "\e[91msudo usage is not restricted to wheel group only..\e[39m"
  #exit
else
  echo -e "\e[92msudo usage is restricted to wheel group only."
fi

echo -e "\e[39m"

