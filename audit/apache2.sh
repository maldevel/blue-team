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
echo -e "\e[1;95m-------------------------[apache2 audit in progress]-------------------------"

installed=$(dpkg-query -W -f='${Status}' apache2 2>/dev/null | grep -c "ok installed")
if [ $installed -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking apache2 installation\t\t\t\t\t\t\t$status"

if [ ! -f /etc/apache2/apache2.conf ]; 
then
  status="\e[91m[ BAD ]"
  echo -e "\e[39m[*] Checking if /etc/apache2/apache2.conf exists\t\t\t\t\t$status\e[39m"
else
    signature=$(grep -cP '^ServerSignature\s+Off$' /etc/apache2/apache2.conf)
    if [ $signature -eq 0 ];
    then
      status="\e[91m[ BAD ]"
      #exit
    else
      status="\e[92m[ GOOD ]"
    fi
    echo -e "\e[39m[*] Checking if apache2 version is hidden\t\t\t\t\t\t$status"

    token=$(grep -cP '^ServerTokens\s+Prod$' /etc/apache2/apache2.conf)
    if [ $token -eq 0 ];
    then
      status="\e[91m[ BAD ]"
      #exit
    else
      status="\e[92m[ GOOD ]"
    fi
    echo -e "\e[39m[*] Checking if ServerTokens has been set\t\t\t\t\t\t$status"

    token=$(grep -cP '^FileETag\sNone$' /etc/apache2/apache2.conf)
    if [ $token -eq 0 ];
    then
      status="\e[91m[ BAD ]"
      #exit
    else
      status="\e[92m[ GOOD ]"
    fi
    echo -e "\e[39m[*] Checking if ETags is disabled\t\t\t\t\t\t\t$status"

    cipher=$(grep -cP "^Timeout 60$" /etc/apache2/apache2.conf)
    if [ $cipher -eq 0 ];
    then
      status="\e[91m[ BAD ]"
      #exit
    else
      status="\e[92m[ GOOD ]"
    fi
    echo -e "\e[39m[*] Checking if DoS attacks Protection is enabled\t\t\t\t\t$status"
fi

indexmod=$(apache2ctl -M 2>/dev/null|grep -c autoindex)
if [ $indexmod -eq 1 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking if autoindex module is disabled\t\t\t\t\t\t$status"

indexmod=$(cat /var/www/html/index.html|wc -w)
if [ $indexmod -ne 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking if index.html is empty\t\t\t\t\t\t\t$status"

if [ ! -f /etc/apache2/apache2.conf ]; 
then
  status="\e[91m[ BAD ]"
  echo -e "\e[39m[*] Checking if /etc/apache2/conf-available/security.conf exists\t\t\t$status\e[39m"
else
    rdir=$(grep -cPzo '<Directory\s+/>\nOptions\s+-Indexes\nAllowOverride\s+None\nOrder\s+Deny,Allow\nDeny\s+from\s+all\n</Directory>' /etc/apache2/conf-available/security.conf)
    if [ $rdir -eq 0 ];
    then
      status="\e[91m[ BAD ]"
      #exit
    else
      status="\e[92m[ GOOD ]"
    fi
    echo -e "\e[39m[*] Checking if root directory is secured\t\t\t\t\t\t$status"

    rdir=$(grep -cPzo '<Directory\s+/var/www/html>\nOptions\s+-Indexes\s+-Includes\nAllowOverride\s+None\nOrder\s+Allow,Deny\nAllow\s+from\s+All\n</Directory>\n' /etc/apache2/conf-available/security.conf)
    if [ $rdir -eq 0 ];
    then
      status="\e[91m[ BAD ]"
      #exit
    else
      status="\e[92m[ GOOD ]"
    fi
    echo -e "\e[39m[*] Checking if html directory is secured\t\t\t\t\t\t$status"

    cipher=$(grep -cP '^Header\sedit\sSet-Cookie\s\^\(\.\*\)\$\s\$1;HttpOnly;Secure$' /etc/apache2/conf-available/security.conf)
    if [ $cipher -eq 0 ];
    then
      status="\e[91m[ BAD ]"
      #exit
    else
      status="\e[92m[ GOOD ]"
    fi
    echo -e "\e[39m[*] Checking if HttpOnly and Secure flags are enabled\t\t\t\t\t$status"

    cipher=$(grep -cP '^Header\salways\sappend\sX-Frame-Options\sSAMEORIGIN$' /etc/apache2/conf-available/security.conf)
    if [ $cipher -eq 0 ];
    then
      status="\e[91m[ BAD ]"
      #exit
    else
      status="\e[92m[ GOOD ]"
    fi
    echo -e "\e[39m[*] Checking if Clickjacking Attack Protection is enabled\t\t\t\t$status"

    cipher=$(grep -cP '^Header\sset\sX-XSS-Protection\s"1;\smode=block"$' /etc/apache2/conf-available/security.conf)
    if [ $cipher -eq 0 ];
    then
      status="\e[91m[ BAD ]"
      #exit
    else
      status="\e[92m[ GOOD ]"
    fi
    echo -e "\e[39m[*] Checking if XSS Protection is enabled\t\t\t\t\t\t$status"

    cipher=$(grep -cP '^Header\salways\sset\sStrict-Transport-Security\s"max-age=31536000;\sincludeSubDomains"$' /etc/apache2/conf-available/security.conf)
    if [ $cipher -eq 0 ];
    then
      status="\e[91m[ BAD ]"
      #exit
    else
      status="\e[92m[ GOOD ]"
    fi
    echo -e "\e[39m[*] Checking if Enforce secure connections is enabled\t\t\t\t\t$status"

    cipher=$(grep -cP '^Header\sset\sX-Content-Type-Options:\s"nosniff"$' /etc/apache2/conf-available/security.conf)
    if [ $cipher -eq 0 ];
    then
      status="\e[91m[ BAD ]"
      #exit
    else
      status="\e[92m[ GOOD ]"
    fi
    echo -e "\e[39m[*] Checking if MIME sniffing Protection is enabled\t\t\t\t\t$status"

    cipher=$(grep -cP "^Header\sset\sContent-Security-Policy\s\"default-src\s'self';\"$" /etc/apache2/conf-available/security.conf)
    if [ $cipher -eq 0 ];
    then
      status="\e[91m[ BAD ]"
      #exit
    else
      status="\e[92m[ GOOD ]"
    fi
    echo -e "\e[39m[*] Checking if Cross-site scripting and injections Protection is enabled\t\t$status"
fi

if [ ! -f /etc/apache2/mods-available/ssl.conf ]; 
then
  status="\e[91m[ BAD ]"
  echo -e "\e[39m[*] Checking if /etc/apache2/mods-available/ssl.conf exists\t\t\t\t$status\e[39m"
else
    tls=$(grep -cP '^\s+SSLProtocol\s+\–ALL\s+\+TLSv1\s+\+TLSv1\.1\s+\+TLSv1\.2$' /etc/apache2/mods-available/ssl.conf)
    if [ $tls -eq 0 ];
    then
      status="\e[91m[ BAD ]"
      #exit
    else
      status="\e[92m[ GOOD ]"
    fi
    echo -e "\e[39m[*] Checking if only TLS SSL Protocol is enabled\t\t\t\t\t$status"

    cipher=$(grep -cP '^\s+SSLCipherSuite\s+HIGH\:\!MEDIUM\:\!aNULL\:\!MD5\:\!RC4$' /etc/apache2/mods-available/ssl.conf)
    if [ $cipher -eq 0 ];
    then
      status="\e[91m[ BAD ]"
      #exit
    else
      status="\e[92m[ GOOD ]"
    fi
    echo -e "\e[39m[*] Checking if strong SSL Cipher Suites are enabled\t\t\t\t\t$status"
fi

indexmod=$(apache2ctl -M 2>/dev/null|grep -c headers)
if [ $indexmod -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking if headers module is enabled\t\t\t\t\t\t$status"

echo -e "\033[0m"

