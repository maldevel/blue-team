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
echo -e "\e[97m>> users and groups audit in progress <<"
echo

echo -e "\e[96m>> Checking Maximum number of days of password usage.."
signature=$(grep -cP '^PASS_MAX_DAYS\s+90$' /etc/login.defs)
if [ $signature -eq 0 ];
then
  echo -e "\e[91mMaximum number of days has not been set to 90..\e[39m"
  #exit
else
  echo -e "\e[92mMaximum number of days has been set to 90."
fi

echo 

echo -e "\e[96m>> Checking Minimum number of days between password changes.."
signature=$(grep -cP '^PASS_MIN_DAYS\s+5$' /etc/login.defs)
if [ $signature -eq 0 ];
then
  echo -e "\e[91mMinimum number of days has not been set to 5..\e[39m"
  #exit
else
  echo -e "\e[92mMinimum number of days has been set to 5."
fi

echo 

echo -e "\e[96m>> Checking Number of days warning before password expiration.."
signature=$(grep -cP '^PASS_WARN_AGE\s+10$' /etc/login.defs)
if [ $signature -eq 0 ];
then
  echo -e "\e[91mMinimum number of days has not been set to 5..\e[39m"
  #exit
else
  echo -e "\e[92mMinimum number of days has been set to 5."
fi

echo 

echo -e "\e[96m>> Checking users locking after inactivity.."
signature=$(useradd -D | grep -cP '^INACTIVE=30$')
if [ $signature -eq 0 ];
then
  echo -e "\e[91musers locking after inactivity has not been set to 30..\e[39m"
  #exit
else
  echo -e "\e[92musers locking after inactivity has been set to 30."
fi

echo 

echo -e "\e[96m>> Checking root primary group.."
signature=$(id -gn root| grep -cP '^root$')
if [ $signature -eq 0 ];
then
  echo -e "\e[91mroot primary group is not root..\e[39m"
  #exit
else
  echo -e "\e[92mroot primary group is root."
fi

echo 

echo -e "\e[96m>> Checking libpam-cracklib installation.."
installed=$(dpkg-query -W -f='${Status}' libpam-cracklib 2>/dev/null | grep -c "ok installed")
if [ $installed -eq 0 ];
then
  echo -e "\e[91mlibpam-cracklib is not installed..\e[39m"
  #exit
else
  echo -e "\e[92mlibpam-cracklib is already installed."
fi

echo 

echo -e "\e[96m>> Checking minimum password length.."
signature=$(grep -cP '.*minlen=14.*' /etc/pam.d/common-password)
if [ $signature -eq 0 ];
then
  echo -e "\e[91mminimum password length has not been set to 14..\e[39m"
  #exit
else
  echo -e "\e[92mminimum password length has been set to 14."
fi

echo 

echo -e "\e[96m>> Checking if username in password is allowed.."
signature=$(grep -cP '.*reject_username.*' /etc/pam.d/common-password)
if [ $signature -eq 0 ];
then
  echo -e "\e[91musername in password is allowed..\e[39m"
  #exit
else
  echo -e "\e[92musername in password is not allowed."
fi

echo 

echo -e "\e[96m>> Checking if Password complexity class.."
signature=$(grep -cP '.*minclass=4.*' /etc/pam.d/common-password)
if [ $signature -eq 0 ];
then
  echo -e "\e[91mPassword complexity class is not 4..\e[39m"
  #exit
else
  echo -e "\e[92mPassword complexity class is 4."
fi

signature=$(grep -cP '.*dcredit=-1 ucredit=-1 ocredit=-1 lcredit=-1.*' /etc/pam.d/common-password)
if [ $signature -eq 0 ];
then
  echo -e "\e[91mPassword complexity is not configured..\e[39m"
  #exit
else
  echo -e "\e[92mPassword complexity is configured."
fi

echo 

echo -e "\e[96m>> Checking if passwords which contain more than 2 same consecutive characters are rejected.."
signature=$(grep -cP '.*maxrepeat=2.*' /etc/pam.d/common-password)
if [ $signature -eq 0 ];
then
  echo -e "\e[91mpasswords which contain more than 2 same consecutive characters are not rejected..\e[39m"
  #exit
else
  echo -e "\e[92mpasswords which contain more than 2 same consecutive characters are rejected."
fi

echo 

echo -e "\e[96m>> Checking last 24 passwords is enabled.."
signature=$(grep -cP '.*remember=24.*' /etc/pam.d/common-password)
if [ $signature -eq 0 ];
then
  echo -e "\e[91mlast 24 passwords is not enabled..\e[39m"
  #exit
else
  echo -e "\e[92mlast 24 passwords is enabled."
fi

echo 

echo -e "\e[96m>> Checking if accounts are getting locked out after unsuccessful consecutive login attempts.."
signature=$(grep -cP '.*auth required pam_tally2\.so onerr=fail audit silent deny=5 unlock_time=1200.*' /etc/pam.d/login)
if [ $signature -eq 0 ];
then
  echo -e "\e[91maccounts are not getting locked out after 5 unsuccessful consecutive login attempts for 20 minutes..\e[39m"
  #exit
else
  echo -e "\e[92maccounts are getting locked out after 5 unsuccessful consecutive login attempts for 20 minutes."
fi

echo 

echo -e "\e[96m>> Checking if non-local logins to privileged accounts are not allowed.."
signature=$(grep -cP '^-:wheel:ALL EXCEPT LOCAL.*' /etc/security/access.conf)
if [ $signature -eq 0 ];
then
  echo -e "\e[91mnon-local logins to privileged accounts are allowed..\e[39m"
  #exit
else
  echo -e "\e[92mnon-local logins to privileged accounts are not allowed."
fi

echo 

echo -e "\e[96m>> Checking delay time between login prompts.."
signature=$(grep -cP '.*delay=10000000.*' /etc/pam.d/login)
if [ $signature -eq 0 ];
then
  echo -e "\e[91mdelay time between login prompts has not been set to 10s..\e[39m"
  #exit
else
  echo -e "\e[92mdelay time between login prompts has been set to 10s."
fi

echo -e "\e[39m"

