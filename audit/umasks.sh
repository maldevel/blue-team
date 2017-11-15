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
echo -e "\e[97m>> umask audit in progress <<"
echo

echo -e "\e[96m>> Checking if umask has been set for users.."
umasklogin=$(grep -cP '^UMASK\s+077$' /etc/login.defs)
if [ $umasklogin -eq 0 ];
then
  echo -e "\e[91mumask has not been set for users..\e[39m"
  #exit
else
  echo -e "\e[92mumask has been set for users."
fi

echo 

echo -e "\e[96m>> Checking if umask has been set for root.."
umasklogin=$(grep -cP '^umask\s+077$' /root/.bashrc)
if [ $umasklogin -eq 0 ];
then
  echo -e "\e[91mumask has not been set for root..\e[39m"
  #exit
else
  echo -e "\e[92mumask has been set for root."
fi

echo -e "\e[39m"

