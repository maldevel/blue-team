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
echo -e "\e[97m>> ssh audit in progress <<"
echo

echo -e "\e[96m>> Checking /etc/ssh/sshd_config.."
fileowner=$(ls -l /etc/ssh/sshd_config| awk '{ print $3 }'|grep -c root)
if [ $fileowner -eq 0 ];
then
  echo -e "\e[91m/etc/ssh/sshd_config is not owned by root..\e[39m"
  #exit
else
  echo -e "\e[92m/etc/ssh/sshd_config is owned by root."
fi

filegroup=$(ls -l /etc/ssh/sshd_config| awk '{ print $4 }'|grep -c root)
if [ $filegroup -eq 0 ];
then
  echo -e "\e[91m/etc/ssh/sshd_config group is not root..\e[39m"
  #exit
else
  echo -e "\e[92m/etc/ssh/sshd_config group is root."
fi

fileperms=$(stat --format '%a' /etc/ssh/sshd_config|grep -c 600)
if [ $fileperms -eq 0 ];
then
  echo -e "\e[91m/etc/ssh/sshd_config permissions are not 600..\e[39m"
  #exit
else
  echo -e "\e[92m/etc/ssh/sshd_config permissions are 600."
fi

echo 

echo -e "\e[96m>> Checking if port has been changed.."
signature=$(grep -cP '^Port 62111$' /etc/ssh/sshd_config)
if [ $signature -eq 0 ];
then
  echo -e "\e[91mport has not been changed..\e[39m"
  #exit
else
  echo -e "\e[92mport has been changed."
fi

echo 

echo -e "\e[96m>> Checking if Protocol 2 is enabled.."
signature=$(grep -cP '^Protocol 2$' /etc/ssh/sshd_config)
if [ $signature -eq 0 ];
then
  echo -e "\e[91mProtocol 2 is not enabled..\e[39m"
  #exit
else
  echo -e "\e[92mProtocol 2 is enabled."
fi

echo 

echo -e "\e[96m>> Checking if LogLevel is set to INFO.."
signature=$(grep -cP '^LogLevel INFO$' /etc/ssh/sshd_config)
if [ $signature -eq 0 ];
then
  echo -e "\e[91mLogLevel is not set to INFO..\e[39m"
  #exit
else
  echo -e "\e[92mLogLevel is set to INFO."
fi

echo 

echo -e "\e[96m>> Checking if MaxAuthTries is set to 3.."
signature=$(grep -cP '^MaxAuthTries 3$' /etc/ssh/sshd_config)
if [ $signature -eq 0 ];
then
  echo -e "\e[91mMaxAuthTries is not set to 3..\e[39m"
  #exit
else
  echo -e "\e[92mMaxAuthTries is set to 3."
fi

echo 

echo -e "\e[96m>> Checking if IgnoreRhosts is enabled.."
signature=$(grep -cP '^IgnoreRhosts yes$' /etc/ssh/sshd_config)
if [ $signature -eq 0 ];
then
  echo -e "\e[91mIgnoreRhosts is not enabled..\e[39m"
  #exit
else
  echo -e "\e[92mIgnoreRhosts is enabled."
fi

echo 

echo -e "\e[96m>> Checking if HostbasedAuthentication is disabled.."
signature=$(grep -cP '^HostbasedAuthentication\sno$' /etc/ssh/sshd_config)
if [ $signature -eq 0 ];
then
  echo -e "\e[91mHostbasedAuthentication is not disabled..\e[39m"
  #exit
else
  echo -e "\e[92mHostbasedAuthentication is disabled."
fi

echo 

echo -e "\e[96m>> Checking if root login is enabled.."
signature=$(grep -cP '^PermitRootLogin\sno$' /etc/ssh/sshd_config)
if [ $signature -eq 0 ];
then
  echo -e "\e[91mroot login is not enabled..\e[39m"
  #exit
else
  echo -e "\e[92mroot login is enabled."
fi

echo 

echo -e "\e[96m>> Checking if Empty Passwords are disabled.."
signature=$(grep -cP '^PermitEmptyPasswords\sno$' /etc/ssh/sshd_config)
if [ $signature -eq 0 ];
then
  echo -e "\e[91mEmpty Passwords are disabled..\e[39m"
  #exit
else
  echo -e "\e[92mEmpty Passwords are disabled."
fi

echo 

echo -e "\e[96m>> Checking if users are allowed to set environment options through the SSH daemon.."
signature=$(grep -cP '^PermitUserEnvironment\sno$' /etc/ssh/sshd_config)
if [ $signature -eq 0 ];
then
  echo -e "\e[91musers are not allowed to set environment options through the SSH daemon..\e[39m"
  #exit
else
  echo -e "\e[92musers are allowed to set environment options through the SSH daemon."
fi

echo 

echo -e "\e[96m>> Checking if only approved ciphers are allowed.."
signature=$(grep -cP '^Ciphers aes256-ctr$' /etc/ssh/sshd_config)
if [ $signature -eq 0 ];
then
  echo -e "\e[91mnon approved ciphers are allowed..\e[39m"
  #exit
else
  echo -e "\e[92mapproved ciphers are allowed only."
fi

echo 

echo -e "\e[96m>> Checking if MAC is set.."
signature=$(grep -cP '^MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512,hmac-sha2-256$' /etc/ssh/sshd_config)
if [ $signature -eq 0 ];
then
  echo -e "\e[91mMAC is not set..\e[39m"
  #exit
else
  echo -e "\e[92mMAC is set."
fi

echo 

echo -e "\e[96m>> Checking if Idle Timeout is configured.."
signature=$(grep -cP '^ClientAliveInterval 300$' /etc/ssh/sshd_config)
if [ $signature -eq 0 ];
then
  echo -e "\e[91mIdle Timeout Interval is not configured..\e[39m"
  #exit
else
  echo -e "\e[92mIdle Timeout Interval is configured."
fi

signature=$(grep -cP '^ClientAliveCountMax 0$' /etc/ssh/sshd_config)
if [ $signature -eq 0 ];
then
  echo -e "\e[91mClient Alive Counter is not configured..\e[39m"
  #exit
else
  echo -e "\e[92mClient Alive Counter is configured."
fi

echo 

echo -e "\e[96m>> Checking if Banner is configured.."
signature=$(grep -cP '^Banner \/etc\/issue\.net$' /etc/ssh/sshd_config)
if [ $signature -eq 0 ];
then
  echo -e "\e[91mBanner is not configured..\e[39m"
  #exit
else
  echo -e "\e[92mBanner is configured."
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

echo 

echo -e "\e[96m>> Checking if only wheel group is allowed to access ssh.."
signature=$(grep -cP '^AllowGroups wheel$' /etc/ssh/sshd_config)
if [ $signature -eq 0 ];
then
  echo -e "\e[91mwheel group is not the only group allowed to access ssh..\e[39m"
  #exit
else
  echo -e "\e[92monly wheel group is allowed to access ssh."
fi

echo 

echo -e "\e[96m>> Checking if X11 forwarding is disabled.."
signature=$(grep -cP '^#X11Forwarding yes$' /etc/ssh/sshd_config)
if [ $signature -eq 0 ];
then
  echo -e "\e[91mX11 forwarding is not disabled..\e[39m"
  #exit
else
  echo -e "\e[92mX11 forwarding is disabled."
fi

echo -e "\e[39m"

