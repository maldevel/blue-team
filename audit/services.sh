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
echo -e "\e[1;95m-------------------------[services audit in progress]-------------------------"


service=$(systemctl is-active avahi-daemon >/dev/null 2>&1 && echo 1 || echo 0)
if [ $service -eq 1 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking if avahi-daemon service is disabled\t\t\t\t\t$status"

service=$(systemctl is-active cups >/dev/null 2>&1 && echo 1 || echo 0)
if [ $service -eq 1 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking if cups service is disabled\t\t\t\t\t\t$status"

service=$(systemctl is-active rpcbind >/dev/null 2>&1 && echo 1 || echo 0)
if [ $service -eq 1 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking if rpcbind service is disabled\t\t\t\t\t\t$status"

echo -e "\033[0m"

