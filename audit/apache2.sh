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
echo -e "\e[97m>> apache2 audit in progress <<"
echo

echo -e "\e[96m>> Checking apache2 installation.."
installed=$(dpkg-query -W -f='${Status}' apache2 2>/dev/null | grep -c "ok installed")
if [ $installed -eq 0 ];
then
  echo -e "\e[91mapache2 is not installed..\e[39m"
  #exit
else
  echo -e "\e[92mapache2 is already installed."
fi

echo 

echo -e "\e[96m>> Checking if apache2 version is hidden.."
signature=$(grep -cP '^ServerSignature\s+Off$' /etc/apache2/apache2.conf)
if [ $signature -eq 0 ];
then
  echo -e "\e[91mapache2 signature is not hidden..\e[39m"
  #exit
else
  echo -e "\e[92mapache2 signature is hidden."
fi

token=$(grep -cP '^ServerTokens\s+Prod$' /etc/apache2/apache2.conf)
if [ $token -eq 0 ];
then
  echo -e "\e[91mapache2 token is not hidden..\e[39m"
  #exit
else
  echo -e "\e[92mapache2 token is hidden."
fi

echo 

echo -e "\e[96m>> Checking if ETags is disabled.."
token=$(grep -cP '^FileETag\s+None$' /etc/apache2/apache2.conf)
if [ $token -eq 1 ];
then
  echo -e "\e[91mapache2 ETags is not disabled..\e[39m"
  #exit
else
  echo -e "\e[92mapache2 ETags is disabled."
fi

echo 

echo -e "\e[96m>> Checking if autoindex module is disabled.."
indexmod=$(apache2ctl -M 2>/dev/null|grep -c autoindex)
if [ $indexmod -eq 1 ];
then
  echo -e "\e[91mautoindex module is not disabled..\e[39m"
  #exit
else
  echo -e "\e[92mautoindex module is disabled."
fi

echo 

echo -e "\e[96m>> Checking if index.html is empty.."
indexmod=$(cat /var/www/html/index.html|wc -w)
if [ $indexmod -ne 0 ];
then
  echo -e "\e[91mindex.html is not empty..\e[39m"
  #exit
else
  echo -e "\e[92mindex.html is empty."
fi

echo 

echo -e "\e[96m>> Checking if root directory is secured.."
rdir=$(grep -cPzo '<Directory\s+/>\nOptions\s+-Indexes\nAllowOverride\s+None\nOrder\s+Deny,Allow\nDeny\s+from\s+all\n</Directory>' /etc/apache2/conf-available/security.conf)
if [ $rdir -eq 0 ];
then
  echo -e "\e[91mroot directory is not secured..\e[39m"
  #exit
else
  echo -e "\e[92mroot directory is secured."
fi

echo 

echo -e "\e[96m>> Checking if html directory is secured.."
rdir=$(grep -cPzo '<Directory\s+/var/www/html>\nOptions\s+-Indexes\s+-Includes\nAllowOverride\s+None\nOrder\s+Allow,Deny\nAllow\s+from\s+All\n</Directory>\n' /etc/apache2/conf-available/security.conf)
if [ $rdir -eq 0 ];
then
  echo -e "\e[91mhtml directory is not secured..\e[39m"
  #exit
else
  echo -e "\e[92mhtml directory is secured."
fi

echo 

echo -e "\e[96m>> Checking if only TLS SSL Protocol is enabled.."
tls=$(grep -cP '^\s+SSLProtocol\s+\–ALL\s+\+TLSv1\s+\+TLSv1\.1\s+\+TLSv1\.2$' /etc/apache2/mods-available/ssl.conf)
if [ $tls -eq 0 ];
then
  echo -e "\e[91mTLS SSL Protocol is not configured..\e[39m"
  #exit
else
  echo -e "\e[92mTLS SSL Protocol is configured."
fi

echo 

echo -e "\e[96m>> Checking if strong SSL Cipher Suites are enabled.."
cipher=$(grep -cP '^\s+SSLCipherSuite\s+HIGH\:\!MEDIUM\:\!aNULL\:\!MD5\:\!RC4$' /etc/apache2/mods-available/ssl.conf)
if [ $cipher -eq 0 ];
then
  echo -e "\e[91mstrong SSL Cipher Suites are not enabled..\e[39m"
  #exit
else
  echo -e "\e[92mstrong SSL Cipher Suites are enabled."
fi

echo 

echo -e "\e[96m>> Checking if headers module is enabled.."
indexmod=$(apache2ctl -M 2>/dev/null|grep -c headers)
if [ $indexmod -eq 0 ];
then
  echo -e "\e[91mheaders module is not enabled..\e[39m"
  #exit
else
  echo -e "\e[92mheaders module is enabled."
fi

echo 

echo -e "\e[96m>> Checking if HttpOnly and Secure flags are enabled.."
cipher=$(grep -cP '^Header\sedit\sSet-Cookie\s\^\(\.\*\)\$\s\$1;HttpOnly;Secure$' /etc/apache2/conf-available/security.conf)
if [ $cipher -eq 0 ];
then
  echo -e "\e[91mHttpOnly and Secure flags are not enabled..\e[39m"
  #exit
else
  echo -e "\e[92mHttpOnly and Secure flags are enabled."
fi

echo 

echo -e "\e[96m>> Checking if Clickjacking Attack Protection is enabled.."
cipher=$(grep -cP '^Header\salways\sappend\sX-Frame-Options\sSAMEORIGIN$' /etc/apache2/conf-available/security.conf)
if [ $cipher -eq 0 ];
then
  echo -e "\e[91mClickjacking Attack Protection is not enabled..\e[39m"
  #exit
else
  echo -e "\e[92mClickjacking Attack Protection is enabled."
fi

echo 

echo -e "\e[96m>> Checking if XSS Protection is enabled.."
cipher=$(grep -cP '^Header\sset\sX-XSS-Protection\s"1;\smode=block"$' /etc/apache2/conf-available/security.conf)
if [ $cipher -eq 0 ];
then
  echo -e "\e[91mXSS Protection is not enabled..\e[39m"
  #exit
else
  echo -e "\e[92mXSS Protection is enabled."
fi

echo 

echo -e "\e[96m>> Checking if Enforce secure connections is enabled.."
cipher=$(grep -cP '^Header\salways\sset\sStrict-Transport-Security\s"max-age=31536000;\sincludeSubDomains"$' /etc/apache2/conf-available/security.conf)
if [ $cipher -eq 0 ];
then
  echo -e "\e[91mEnforce secure connections is not enabled..\e[39m"
  #exit
else
  echo -e "\e[92mEnforce secure connections is enabled."
fi

echo 

echo -e "\e[96m>> Checking if MIME sniffing Protection is enabled.."
cipher=$(grep -cP '^Header\sset\sX-Content-Type-Options:\s"nosniff"$' /etc/apache2/conf-available/security.conf)
if [ $cipher -eq 0 ];
then
  echo -e "\e[91mMIME sniffing Protection is not enabled..\e[39m"
  #exit
else
  echo -e "\e[92mMIME sniffing Protection is enabled."
fi

echo 

echo -e "\e[96m>> Checking if Cross-site scripting and injections Protection is enabled.."
cipher=$(grep -cP "^Header\sset\sContent-Security-Policy\s\"default-src\s'self';\"$" /etc/apache2/conf-available/security.conf)
if [ $cipher -eq 0 ];
then
  echo -e "\e[91mCross-site scripting and injections Protection is not enabled..\e[39m"
  #exit
else
  echo -e "\e[92mCross-site scripting and injections Protection is enabled."
fi

echo 

echo -e "\e[96m>> Checking if DoS attacks Protection is enabled.."
cipher=$(grep -cP "^Timeout 60$" /etc/apache2/apache2.conf)
if [ $cipher -eq 0 ];
then
  echo -e "\e[91mDoS attacks Protection is not enabled..\e[39m"
  #exit
else
  echo -e "\e[92mDoS attacks Protection is enabled."
fi

echo 

echo -e "\e[39m"

