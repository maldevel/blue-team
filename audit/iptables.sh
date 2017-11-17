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
echo -e "\e[97m>> iptables audit in progress <<"
echo

echo -e "\e[96m>> Checking iptables installation.."
installed=$(dpkg-query -W -f='${Status}' iptables 2>/dev/null | grep -c "ok installed")
if [ $installed -eq 0 ];
then
  echo -e "\e[91miptables is not installed..\e[39m"
  #exit
else
  echo -e "\e[92miptables is already installed."
fi

echo 

echo -e "\e[96m>> Checking iptables-persistent installation.."
installed=$(dpkg-query -W -f='${Status}' iptables-persistent 2>/dev/null | grep -c "ok installed")
if [ $installed -eq 0 ];
then
  echo -e "\e[91miptables-persistent is not installed..\e[39m"
  #exit
else
  echo -e "\e[92miptables-persistent is already installed."
fi

echo 

echo -e "\e[96m>> Checking if netfilter-persistent service is enabled..\e[39m"
systemctl is-enabled netfilter-persistent

echo 

echo -e "\e[96m>> Checking if null packets are blocked.."
nullpackets=$(iptables-save | grep -cP '^-A\sINPUT\s-p\stcp\s-m\stcp\s--tcp-flags\sFIN,SYN,RST,PSH,ACK,URG\sNONE\s-j\sDROP$')
if [ $nullpackets -eq 0 ];
then
  echo -e "\e[91mnull packets are not blocked..\e[39m"
  #exit
else
  echo -e "\e[92mnull packets are blocked."
fi

echo 

echo -e "\e[96m>> Checking if syn-flood attacks are blocked.."
nullpackets=$(iptables-save | grep -cP '^-A\sINPUT\s-p\stcp\s-m\stcp\s!\s--tcp-flags\sFIN,SYN,RST,ACK\sSYN\s-m\sstate\s--state\sNEW\s-j\sDROP$')
if [ $nullpackets -eq 0 ];
then
  echo -e "\e[91msyn-flood attacks are not blocked..\e[39m"
  #exit
else
  echo -e "\e[92msyn-flood attacks are blocked."
fi

echo 

echo -e "\e[96m>> Checking if XMAS packets are blocked.."
nullpackets=$(iptables-save | grep -cP '^-A\sINPUT\s-p\stcp\s-m\stcp\s--tcp-flags\sFIN,SYN,RST,PSH,ACK,URG FIN,SYN,RST,PSH,ACK,URG\s-j\sDROP$')
if [ $nullpackets -eq 0 ];
then
  echo -e "\e[91mXMAS packets are not blocked..\e[39m"
  #exit
else
  echo -e "\e[92mXMAS packets are blocked."
fi

echo 

echo -e "\e[96m>> Checking if internal traffic on the loopback device is allowed.."
nullpackets=$(iptables-save | grep -cP '^-A\sINPUT\s-i\slo\s-j\sACCEPT$')
if [ $nullpackets -eq 0 ];
then
  echo -e "\e[91minternal traffic on the loopback device is not allowed..\e[39m"
  #exit
else
  echo -e "\e[92minternal traffic on the loopback device is allowed."
fi

echo 

echo -e "\e[96m>> Checking if ssh access is allowed.."
nullpackets=$(iptables-save | grep -cP '^-A\sINPUT\s-p\stcp\s-m\stcp\s--dport\s22\s-j\sACCEPT$')
if [ $nullpackets -eq 0 ];
then
  echo -e "\e[91mssh access is not allowed..\e[39m"
  #exit
else
  echo -e "\e[92mssh access is allowed."
fi

echo 

echo -e "\e[96m>> Checking if established connections are allowed.."
nullpackets=$(iptables-save | grep -cP '^-A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT$')
if [ $nullpackets -eq 0 ];
then
  echo -e "\e[91mestablished connections are not allowed..\e[39m"
  #exit
else
  echo -e "\e[92mestablished connections are allowed."
fi

echo 

echo -e "\e[96m>> Checking if outgoing connections are allowed.."
nullpackets=$(iptables-save | grep -cP '^:OUTPUT\sACCEPT.*')
if [ $nullpackets -eq 0 ];
then
  echo -e "\e[91moutgoing connections are not allowed..\e[39m"
  #exit
else
  echo -e "\e[92moutgoing connections are allowed."
fi

echo 
  
echo -e "\e[96m>> Checking if default firewall policy is deny.."
nullpackets=$(iptables-save | grep -cP '^:INPUT DROP.*')
if [ $nullpackets -eq 0 ];
then
  echo -e "\e[91mdefault firewall policy is not deny..\e[39m"
  #exit
else
  echo -e "\e[92mdefault firewall policy is deny."
fi

echo -e "\e[39m"

