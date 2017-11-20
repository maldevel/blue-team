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
echo -e "\e[1;95m-------------------------[system files audit in progress]-------------------------"

fileowner=$(ls -l /etc/passwd| awk '{ print $3 }'|grep -c root)
if [ $fileowner -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking /etc/passwd owner\t\t\t\t\t\t\t\t$status"

filegroup=$(ls -l /etc/passwd| awk '{ print $4 }'|grep -c root)
if [ $filegroup -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking /etc/passwd group\t\t\t\t\t\t\t\t$status"

fileperms=$(stat --format '%a' /etc/passwd|grep -c 644)
if [ $fileperms -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking /etc/passwd file permissions\t\t\t\t\t\t$status"

fileowner=$(ls -l /etc/shadow| awk '{ print $3 }'|grep -c root)
if [ $fileowner -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking /etc/shadow owner\t\t\t\t\t\t\t\t$status"

filegroup=$(ls -l /etc/shadow| awk '{ print $4 }'|grep -c shadow)
if [ $filegroup -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking /etc/shadow group\t\t\t\t\t\t\t\t$status"

fileperms=$(stat --format '%a' /etc/shadow|grep -c 640)
if [ $fileperms -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking /etc/shadow file permissions\t\t\t\t\t\t$status"

fileowner=$(ls -l /etc/group| awk '{ print $3 }'|grep -c root)
if [ $fileowner -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking /etc/group owner\t\t\t\t\t\t\t\t$status"

filegroup=$(ls -l /etc/group| awk '{ print $4 }'|grep -c root)
if [ $filegroup -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking /etc/group group\t\t\t\t\t\t\t\t$status"

fileperms=$(stat --format '%a' /etc/group|grep -c 644)
if [ $fileperms -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking /etc/group file permissions\t\t\t\t\t\t$status"

fileowner=$(ls -l /etc/gshadow| awk '{ print $3 }'|grep -c root)
if [ $fileowner -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking /etc/gshadow owner\t\t\t\t\t\t\t\t$status"

filegroup=$(ls -l /etc/gshadow| awk '{ print $4 }'|grep -c shadow)
if [ $filegroup -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking /etc/gshadow group\t\t\t\t\t\t\t\t$status"

fileperms=$(stat --format '%a' /etc/gshadow|grep -c 640)
if [ $fileperms -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking /etc/gshadow file permissions\t\t\t\t\t\t$status"

if [ -f /etc/opasswd ]; then

    fileowner=$(ls -l /etc/opasswd| awk '{ print $3 }'|grep -c root)
    if [ $fileowner -eq 0 ];
    then
      status="\e[91m[ BAD ]"
      #exit
    else
      status="\e[92m[ GOOD ]"
    fi
    echo -e "\e[39m[*] Checking /etc/opasswd owner\t\t\t\t\t\t\t\t$status"
    
    filegroup=$(ls -l /etc/opasswd| awk '{ print $4 }'|grep -c root)
    if [ $filegroup -eq 0 ];
    then
      status="\e[91m[ BAD ]"
      #exit
    else
      status="\e[92m[ GOOD ]"
    fi
    echo -e "\e[39m[*] Checking /etc/opasswd group\t\t\t\t\t\t\t\t$status"
    
    fileperms=$(stat --format '%a' /etc/opasswd|grep -c 600)
    if [ $fileperms -eq 0 ];
    then
      status="\e[91m[ BAD ]"
      #exit
    else
      status="\e[92m[ GOOD ]"
    fi
    echo -e "\e[39m[*] Checking /etc/opasswd file permissions\t\t\t\t\t\t$status"
else
    status="\e[91m[ BAD ]"
    echo -e "\e[39m[*] Checking if /etc/opasswd exists\t\t\t\t\t\t\t$status"
fi

fileowner=$(ls -l /etc/passwd-| awk '{ print $3 }'|grep -c root)
if [ $fileowner -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking /etc/passwd- owner\t\t\t\t\t\t\t\t$status"

filegroup=$(ls -l /etc/passwd-| awk '{ print $4 }'|grep -c root)
if [ $filegroup -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking /etc/passwd- group\t\t\t\t\t\t\t\t$status"

fileperms=$(stat --format '%a' /etc/passwd-|grep -c 600)
if [ $fileperms -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking /etc/passwd- file permissions\t\t\t\t\t\t$status"

fileowner=$(ls -l /etc/shadow-| awk '{ print $3 }'|grep -c root)
if [ $fileowner -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking /etc/shadow- owner\t\t\t\t\t\t\t\t$status"

filegroup=$(ls -l /etc/shadow-| awk '{ print $4 }'|grep -c root)
if [ $filegroup -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking /etc/shadow- group\t\t\t\t\t\t\t\t$status"

fileperms=$(stat --format '%a' /etc/shadow-|grep -c 600)
if [ $fileperms -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking /etc/shadow- file permissions\t\t\t\t\t\t$status"

fileowner=$(ls -l /etc/group-| awk '{ print $3 }'|grep -c root)
if [ $fileowner -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking /etc/group- owner\t\t\t\t\t\t\t\t$status"

filegroup=$(ls -l /etc/group-| awk '{ print $4 }'|grep -c root)
if [ $filegroup -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking /etc/group- group\t\t\t\t\t\t\t\t$status"

fileperms=$(stat --format '%a' /etc/group-|grep -c 600)
if [ $fileperms -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking /etc/group- file permissions\t\t\t\t\t\t$status"

fileowner=$(ls -l /etc/gshadow-| awk '{ print $3 }'|grep -c root)
if [ $fileowner -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking /etc/gshadow- owner\t\t\t\t\t\t\t$status"

filegroup=$(ls -l /etc/gshadow-| awk '{ print $4 }'|grep -c root)
if [ $filegroup -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking /etc/gshadow- group\t\t\t\t\t\t\t$status"

fileperms=$(stat --format '%a' /etc/gshadow-|grep -c 600)
if [ $fileperms -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking /etc/gshadow- file permissions\t\t\t\t\t\t$status"

echo -e "\e[39m"

