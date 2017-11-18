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
echo -e "\e[97m>> nginx audit in progress <<"
echo

echo -e "\e[96m>> Checking nginx installation.."
installed=$(dpkg-query -W -f='${Status}' nginx 2>/dev/null | grep -c "ok installed")
if [ $installed -eq 0 ];
then
  echo -e "\e[91mnginx is not installed..\e[39m"
  #exit
else
  echo -e "\e[92mnginx is already installed."
fi

echo 

echo -e "\e[96m>> Checking if nginx version is hidden.."
signature=$(grep -cP '\s+server_tokens\soff;$' /etc/nginx/nginx.conf)
if [ $signature -eq 0 ];
then
  echo -e "\e[91mnginx signature is not hidden..\e[39m"
  #exit
else
  echo -e "\e[92mnginx signature is hidden."
fi

echo 

echo -e "\e[96m>> Checking if ETags is removed.."
signature=$(grep -cP '^etag\soff;$' /etc/nginx/nginx.conf)
if [ $signature -eq 0 ];
then
  echo -e "\e[91mETags is not removed..\e[39m"
  #exit
else
  echo -e "\e[92mETags is removed."
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

echo -e "\e[96m>> Checking if strong cipher suites are enabled.."
signature=$(grep -cP '^ssl_ciphers ECDHE-RSA-AES256-GCM-SHA512:DHE-RSA-AES256-GCM-SHA512:ECDHE-RSA-AES256-GCM-SHA384:DHE-RSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-SHA384;$' /etc/nginx/nginx.conf)
if [ $signature -eq 0 ];
then
  echo -e "\e[91mstrong cipher suites are not enabled..\e[39m"
  #exit
else
  echo -e "\e[92mstrong cipher suites are enabled."
fi

echo 

echo -e "\e[96m>> Checking if ssl session timeout is set.."
signature=$(grep -cP '^ssl_session_timeout 5m;$' /etc/nginx/nginx.conf)
if [ $signature -eq 0 ];
then
  echo -e "\e[91mssl session timeout is not set..\e[39m"
  #exit
else
  echo -e "\e[92mssl session timeout is set."
fi

echo 

echo -e "\e[96m>> Checking if ssl session cache is set.."
signature=$(grep -cP '^ssl_session_cache shared:SSL:10m;$' /etc/nginx/nginx.conf)
if [ $signature -eq 0 ];
then
  echo -e "\e[91mssl session cache is not set..\e[39m"
  #exit
else
  echo -e "\e[92mssl session cache is set."
fi

echo 

echo -e "\e[96m>> Checking if HttpOnly and Secure flags are enabled.."
signature=$(grep -cP '^proxy_cookie_path / \"/; secure; HttpOnly\";$' /etc/nginx/sites-available/default)
if [ $signature -eq 0 ];
then
  echo -e "\e[91mHttpOnly and Secure flags are not enabled..\e[39m"
  #exit
else
  echo -e "\e[92mHttpOnly and Secure flags are enabled."
fi

echo 

echo -e "\e[96m>> Checking if Clickjacking Attack Protection is enabled.."
signature=$(grep -cP '^add_header X-Frame-Options DENY;$' /etc/nginx/sites-available/default)
if [ $signature -eq 0 ];
then
  echo -e "\e[91mClickjacking Attack Protection is not enabled..\e[39m"
  #exit
else
  echo -e "\e[92mClickjacking Attack Protection is enabled."
fi

echo 

echo -e "\e[96m>> Checking if XSS Protection is enabled.."
signature=$(grep -cP '^add_header X-XSS-Protection \"1; mode=block\";$' /etc/nginx/sites-available/default)
if [ $signature -eq 0 ];
then
  echo -e "\e[91mXSS Protection is not enabled..\e[39m"
  #exit
else
  echo -e "\e[92mXSS Protection is enabled."
fi

echo 

echo -e "\e[96m>> Checking if Enforce secure connections is enabled.."
signature=$(grep -cP '^add_header Strict-Transport-Security \"max-age=31536000; includeSubdomains;\";$' /etc/nginx/sites-available/default)
if [ $signature -eq 0 ];
then
  echo -e "\e[91mEnforce secure connections is not enabled..\e[39m"
  #exit
else
  echo -e "\e[92mEnforce secure connections is enabled."
fi

echo 

echo -e "\e[96m>> Checking if MIME sniffing Protection is enabled.."
signature=$(grep -cP '^add_header X-Content-Type-Options nosniff;$' /etc/nginx/sites-available/default)
if [ $signature -eq 0 ];
then
  echo -e "\e[91mMIME sniffing Protection is not enabled..\e[39m"
  #exit
else
  echo -e "\e[92mMIME sniffing Protection is enabled."
fi

echo 

echo -e "\e[96m>> Checking if Cross-site scripting and injections Protection is enabled.."
signature=$(grep -cP "^add_header Content-Security-Policy \"default-src 'self';\";$" /etc/nginx/sites-available/default)
if [ $signature -eq 0 ];
then
  echo -e "\e[91mCross-site scripting and injections Protection is not enabled..\e[39m"
  #exit
else
  echo -e "\e[92mCross-site scripting and injections Protection is enabled."
fi

echo 

echo -e "\e[96m>> Checking if X-Robots-Tag is set.."
signature=$(grep -cP '^add_header X-Robots-Tag none;$' /etc/nginx/sites-available/default)
if [ $signature -eq 0 ];
then
  echo -e "\e[91mX-Robots-Tag is not set..\e[39m"
  #exit
else
  echo -e "\e[92mX-Robots-Tag is set."
fi

echo 

echo -e "\e[39m"

