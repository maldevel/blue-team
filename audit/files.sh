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
echo -e "\e[97m>> system files audit in progress <<"
echo

echo -e "\e[96m>> Checking /etc/passwd.."
fileowner=$(ls -l /etc/passwd| awk '{ print $3 }'|grep -c root)
if [ $fileowner -eq 0 ];
then
  echo -e "\e[91m/etc/passwd is not owned by root..\e[39m"
  #exit
else
  echo -e "\e[92m/etc/passwd is owned by root."
fi

filegroup=$(ls -l /etc/passwd| awk '{ print $4 }'|grep -c root)
if [ $filegroup -eq 0 ];
then
  echo -e "\e[91m/etc/passwd group is not root..\e[39m"
  #exit
else
  echo -e "\e[92m/etc/passwd group is root."
fi

fileperms=$(stat --format '%a' /etc/passwd|grep -c 644)
if [ $fileperms -eq 0 ];
then
  echo -e "\e[91m/etc/passwd permissions are not 644..\e[39m"
  #exit
else
  echo -e "\e[92m/etc/passwd permissions are 644."
fi

echo 

echo -e "\e[96m>> Checking /etc/shadow.."
fileowner=$(ls -l /etc/shadow| awk '{ print $3 }'|grep -c root)
if [ $fileowner -eq 0 ];
then
  echo -e "\e[91m/etc/shadow is not owned by root..\e[39m"
  #exit
else
  echo -e "\e[92m/etc/shadow is owned by root."
fi

filegroup=$(ls -l /etc/shadow| awk '{ print $4 }'|grep -c shadow)
if [ $filegroup -eq 0 ];
then
  echo -e "\e[91m/etc/shadow group is not root..\e[39m"
  #exit
else
  echo -e "\e[92m/etc/shadow group is root."
fi

fileperms=$(stat --format '%a' /etc/shadow|grep -c 640)
if [ $fileperms -eq 0 ];
then
  echo -e "\e[91m/etc/shadow permissions are not 640..\e[39m"
  #exit
else
  echo -e "\e[92m/etc/shadow permissions are 640."
fi

echo 

echo -e "\e[96m>> Checking /etc/group.."
fileowner=$(ls -l /etc/group| awk '{ print $3 }'|grep -c root)
if [ $fileowner -eq 0 ];
then
  echo -e "\e[91m/etc/group is not owned by root..\e[39m"
  #exit
else
  echo -e "\e[92m/etc/group is owned by root."
fi

filegroup=$(ls -l /etc/group| awk '{ print $4 }'|grep -c root)
if [ $filegroup -eq 0 ];
then
  echo -e "\e[91m/etc/group group is not root..\e[39m"
  #exit
else
  echo -e "\e[92m/etc/group group is root."
fi

fileperms=$(stat --format '%a' /etc/group|grep -c 644)
if [ $fileperms -eq 0 ];
then
  echo -e "\e[91m/etc/group permissions are not 644..\e[39m"
  #exit
else
  echo -e "\e[92m/etc/group permissions are 644."
fi

echo 

echo -e "\e[96m>> Checking /etc/gshadow.."
fileowner=$(ls -l /etc/gshadow| awk '{ print $3 }'|grep -c root)
if [ $fileowner -eq 0 ];
then
  echo -e "\e[91m/etc/gshadow is not owned by root..\e[39m"
  #exit
else
  echo -e "\e[92m/etc/gshadow is owned by root."
fi

filegroup=$(ls -l /etc/gshadow| awk '{ print $4 }'|grep -c shadow)
if [ $filegroup -eq 0 ];
then
  echo -e "\e[91m/etc/gshadow group is not root..\e[39m"
  #exit
else
  echo -e "\e[92m/etc/gshadow group is root."
fi

fileperms=$(stat --format '%a' /etc/gshadow|grep -c 640)
if [ $fileperms -eq 0 ];
then
  echo -e "\e[91m/etc/gshadow permissions are not 640..\e[39m"
  #exit
else
  echo -e "\e[92m/etc/gshadow permissions are 640."
fi

echo 

echo -e "\e[96m>> Checking /etc/opasswd.."
if [ -f /etc/opasswd ]; then

    fileowner=$(ls -l /etc/opasswd| awk '{ print $3 }'|grep -c root)
    if [ $fileowner -eq 0 ];
    then
      echo -e "\e[91m/etc/opasswd is not owned by root..\e[39m"
      #exit
    else
      echo -e "\e[92m/etc/opasswd is owned by root."
    fi

    filegroup=$(ls -l /etc/opasswd| awk '{ print $4 }'|grep -c root)
    if [ $filegroup -eq 0 ];
    then
      echo -e "\e[91m/etc/opasswd group is not root..\e[39m"
      #exit
    else
      echo -e "\e[92m/etc/opasswd group is root."
    fi

    fileperms=$(stat --format '%a' /etc/opasswd|grep -c 600)
    if [ $fileperms -eq 0 ];
    then
      echo -e "\e[91m/etc/opasswd permissions are not 600..\e[39m"
      #exit
    else
      echo -e "\e[92m/etc/opasswd permissions are 600."
    fi
else
    echo -e "\e[92m/etc/opasswd does not exist."
fi

echo 

echo -e "\e[96m>> Checking /etc/passwd-.."
fileowner=$(ls -l /etc/passwd-| awk '{ print $3 }'|grep -c root)
if [ $fileowner -eq 0 ];
then
  echo -e "\e[91m/etc/passwd- is not owned by root..\e[39m"
  #exit
else
  echo -e "\e[92m/etc/passwd- is owned by root."
fi

filegroup=$(ls -l /etc/passwd-| awk '{ print $4 }'|grep -c root)
if [ $filegroup -eq 0 ];
then
  echo -e "\e[91m/etc/passwd- group is not root..\e[39m"
  #exit
else
  echo -e "\e[92m/etc/passwd- group is root."
fi

fileperms=$(stat --format '%a' /etc/passwd-|grep -c 600)
if [ $fileperms -eq 0 ];
then
  echo -e "\e[91m/etc/passwd- permissions are not 600..\e[39m"
  #exit
else
  echo -e "\e[92m/etc/passwd- permissions are 600."
fi

echo 

echo -e "\e[96m>> Checking /etc/shadow-.."
fileowner=$(ls -l /etc/shadow-| awk '{ print $3 }'|grep -c root)
if [ $fileowner -eq 0 ];
then
  echo -e "\e[91m/etc/shadow- is not owned by root..\e[39m"
  #exit
else
  echo -e "\e[92m/etc/shadow- is owned by root."
fi

filegroup=$(ls -l /etc/shadow-| awk '{ print $4 }'|grep -c root)
if [ $filegroup -eq 0 ];
then
  echo -e "\e[91m/etc/shadow- group is not root..\e[39m"
  #exit
else
  echo -e "\e[92m/etc/shadow- group is root."
fi

fileperms=$(stat --format '%a' /etc/shadow-|grep -c 600)
if [ $fileperms -eq 0 ];
then
  echo -e "\e[91m/etc/shadow- permissions are not 600..\e[39m"
  #exit
else
  echo -e "\e[92m/etc/shadow- permissions are 600."
fi

echo 

echo -e "\e[96m>> Checking /etc/group-.."
fileowner=$(ls -l /etc/group-| awk '{ print $3 }'|grep -c root)
if [ $fileowner -eq 0 ];
then
  echo -e "\e[91m/etc/group- is not owned by root..\e[39m"
  #exit
else
  echo -e "\e[92m/etc/group- is owned by root."
fi

filegroup=$(ls -l /etc/group-| awk '{ print $4 }'|grep -c root)
if [ $filegroup -eq 0 ];
then
  echo -e "\e[91m/etc/group- group is not root..\e[39m"
  #exit
else
  echo -e "\e[92m/etc/group- group is root."
fi

fileperms=$(stat --format '%a' /etc/group-|grep -c 600)
if [ $fileperms -eq 0 ];
then
  echo -e "\e[91m/etc/group- permissions are not 600..\e[39m"
  #exit
else
  echo -e "\e[92m/etc/group- permissions are 600."
fi

echo 

echo -e "\e[96m>> Checking /etc/gshadow-.."
fileowner=$(ls -l /etc/gshadow-| awk '{ print $3 }'|grep -c root)
if [ $fileowner -eq 0 ];
then
  echo -e "\e[91m/etc/gshadow- is not owned by root..\e[39m"
  #exit
else
  echo -e "\e[92m/etc/gshadow- is owned by root."
fi

filegroup=$(ls -l /etc/gshadow-| awk '{ print $4 }'|grep -c root)
if [ $filegroup -eq 0 ];
then
  echo -e "\e[91m/etc/gshadow- group is not root..\e[39m"
  #exit
else
  echo -e "\e[92m/etc/gshadow- group is root."
fi

fileperms=$(stat --format '%a' /etc/gshadow-|grep -c 600)
if [ $fileperms -eq 0 ];
then
  echo -e "\e[91m/etc/gshadow- permissions are not 600..\e[39m"
  #exit
else
  echo -e "\e[92m/etc/gshadow- permissions are 600."
fi

echo -e "\e[39m"

