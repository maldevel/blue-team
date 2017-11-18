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
echo -e "\e[97m>> network audit in progress <<"
echo

echo -e "\e[96m>> Checking if IP forwarding is disabled.."
signature=$(grep -cP '^net\.ipv4\.ip_forward=0$' /etc/sysctl.conf)
if [ $signature -eq 0 ];
then
  echo -e "\e[91mIP forwarding is not disabled..\e[39m"
  #exit
else
  echo -e "\e[92mIP forwarding is disabled."
fi

signature=$(sysctl net.ipv4.ip_forward| grep -cP '^net\.ipv4\.ip_forward\s=\s0$')
if [ $signature -eq 0 ];
then
  echo -e "\e[91mIP forwarding is not disabled on active kernel..\e[39m"
  #exit
else
  echo -e "\e[92mIP forwarding is disabled on active kernel."
fi

echo 

echo -e "\e[96m>> Checking if packet redirect is disabled.."
signature=$(grep -cP '^net\.ipv4\.conf\.all\.send_redirects\s=\s0$' /etc/sysctl.conf)
if [ $signature -eq 0 ];
then
  echo -e "\e[91mpacket redirect (all) is not disabled..\e[39m"
  #exit
else
  echo -e "\e[92mpacket redirect (all) is disabled."
fi

signature=$(grep -cP '^net\.ipv4\.conf\.default\.send_redirects=0$' /etc/sysctl.conf)
if [ $signature -eq 0 ];
then
  echo -e "\e[91mpacket redirect (default) is not disabled..\e[39m"
  #exit
else
  echo -e "\e[92mpacket redirect (default) is disabled."
fi

signature=$(sysctl net.ipv4.conf.all.send_redirects| grep -cP '^net\.ipv4\.conf\.all\.send_redirects\s=\s0$')
if [ $signature -eq 0 ];
then
  echo -e "\e[91mpacket redirect (all) is not disabled on active kernel..\e[39m"
  #exit
else
  echo -e "\e[92mpacket redirect (all) is disabled on active kernel."
fi

signature=$(sysctl net.ipv4.conf.default.send_redirects| grep -cP '^net\.ipv4\.conf\.default\.send_redirects\s=\s0$')
if [ $signature -eq 0 ];
then
  echo -e "\e[91mpacket redirect (default) is not disabled on active kernel..\e[39m"
  #exit
else
  echo -e "\e[92mpacket redirect (default) is disabled on active kernel."
fi

echo 

echo -e "\e[96m>> Checking if source routed packets is disabled.."
signature=$(grep -cP '^net\.ipv4\.conf\.all\.accept_source_route\s=\s0$' /etc/sysctl.conf)
if [ $signature -eq 0 ];
then
  echo -e "\e[91msource routed packets (all) is not disabled..\e[39m"
  #exit
else
  echo -e "\e[92msource routed packets (all) is disabled."
fi

signature=$(grep -cP '^net\.ipv4\.conf\.default\.accept_source_route=0$' /etc/sysctl.conf)
if [ $signature -eq 0 ];
then
  echo -e "\e[91msource routed packets (default) is not disabled..\e[39m"
  #exit
else
  echo -e "\e[92msource routed packets (default) is disabled."
fi

signature=$(sysctl net.ipv4.conf.all.accept_source_route| grep -cP '^net\.ipv4\.conf\.all\.accept_source_route\s=\s0$')
if [ $signature -eq 0 ];
then
  echo -e "\e[91msource routed packets (all) is not disabled on active kernel..\e[39m"
  #exit
else
  echo -e "\e[92msource routed packets (all) is disabled on active kernel."
fi

signature=$(sysctl net.ipv4.conf.default.accept_source_route| grep -cP '^net\.ipv4\.conf\.default\.accept_source_route\s=\s0$')
if [ $signature -eq 0 ];
then
  echo -e "\e[91msource routed packets (default) is not disabled on active kernel..\e[39m"
  #exit
else
  echo -e "\e[92msource routed packets (default) is disabled on active kernel."
fi

echo 

echo -e "\e[96m>> Checking if ICMP redirects is disabled.."
signature=$(grep -cP '^net\.ipv4\.conf\.all\.accept_redirects\s=\s0$' /etc/sysctl.conf)
if [ $signature -eq 0 ];
then
  echo -e "\e[91mICMP redirects (all) is not disabled..\e[39m"
  #exit
else
  echo -e "\e[92mICMP redirects (all) is disabled."
fi

signature=$(grep -cP '^net\.ipv4\.conf\.default\.accept_redirects=0$' /etc/sysctl.conf)
if [ $signature -eq 0 ];
then
  echo -e "\e[91mICMP redirects (default) is not disabled..\e[39m"
  #exit
else
  echo -e "\e[92mICMP redirects (default) is disabled."
fi

signature=$(sysctl net.ipv4.conf.all.accept_redirects| grep -cP '^net\.ipv4\.conf\.all\.accept_redirects\s=\s0$')
if [ $signature -eq 0 ];
then
  echo -e "\e[91mICMP redirects (all) is not disabled on active kernel..\e[39m"
  #exit
else
  echo -e "\e[92mICMP redirects (all) is disabled on active kernel."
fi

signature=$(sysctl net.ipv4.conf.default.accept_redirects| grep -cP '^net\.ipv4\.conf\.default\.accept_redirects\s=\s0$')
if [ $signature -eq 0 ];
then
  echo -e "\e[91mICMP redirects (default) is not disabled on active kernel..\e[39m"
  #exit
else
  echo -e "\e[92mICMP redirects (default) is disabled on active kernel."
fi

echo 

echo -e "\e[96m>> Checking if suspicious packets logging is enabled.."
signature=$(grep -cP '^net\.ipv4\.conf\.all\.log_martians\s=\s1$' /etc/sysctl.conf)
if [ $signature -eq 0 ];
then
  echo -e "\e[91msuspicious packets logging (all) is not enabled..\e[39m"
  #exit
else
  echo -e "\e[92msuspicious packets logging (all) is enabled."
fi

signature=$(grep -cP '^net\.ipv4\.conf\.default\.log_martians=1$' /etc/sysctl.conf)
if [ $signature -eq 0 ];
then
  echo -e "\e[91msuspicious packets logging (default) is not enabled..\e[39m"
  #exit
else
  echo -e "\e[92msuspicious packets logging (default) is enabled."
fi

signature=$(sysctl net.ipv4.conf.all.log_martians| grep -cP '^net\.ipv4\.conf\.all\.log_martians\s=\s1$')
if [ $signature -eq 0 ];
then
  echo -e "\e[91msuspicious packets logging (all) is not enabled on active kernel..\e[39m"
  #exit
else
  echo -e "\e[92msuspicious packets logging (all) is enabled on active kernel."
fi

signature=$(sysctl net.ipv4.conf.default.log_martians| grep -cP '^net\.ipv4\.conf\.default\.log_martians\s=\s1$')
if [ $signature -eq 0 ];
then
  echo -e "\e[91msuspicious packets logging (default) is not enabled on active kernel..\e[39m"
  #exit
else
  echo -e "\e[92msuspicious packets logging (default) is enabled on active kernel."
fi

echo 

echo -e "\e[96m>> Checking if broadcast ICMP requests are ignored.."
signature=$(grep -cP '^net\.ipv4\.icmp_echo_ignore_broadcasts=1$' /etc/sysctl.conf)
if [ $signature -eq 0 ];
then
  echo -e "\e[91mbroadcast ICMP requests are not ignored..\e[39m"
  #exit
else
  echo -e "\e[92mbroadcast ICMP requests is ignored."
fi

signature=$(sysctl net.ipv4.icmp_echo_ignore_broadcasts| grep -cP '^net\.ipv4\.icmp_echo_ignore_broadcasts\s=\s1$')
if [ $signature -eq 0 ];
then
  echo -e "\e[91mbroadcast ICMP requests are not ignored on active kernel..\e[39m"
  #exit
else
  echo -e "\e[92mbroadcast ICMP requests are ignored on active kernel."
fi

echo 

echo -e "\e[96m>> Checking if Bad Error Message Protection is enabled.."
signature=$(grep -cP '^net\.ipv4\.icmp_ignore_bogus_error_responses=1$' /etc/sysctl.conf)
if [ $signature -eq 0 ];
then
  echo -e "\e[91mBad Error Message Protection is not enabled..\e[39m"
  #exit
else
  echo -e "\e[92mBad Error Message Protection is enabled."
fi

signature=$(sysctl net.ipv4.icmp_ignore_bogus_error_responses| grep -cP '^net\.ipv4\.icmp_ignore_bogus_error_responses\s=\s1$')
if [ $signature -eq 0 ];
then
  echo -e "\e[91mBad Error Message Protection is not enabled on active kernel..\e[39m"
  #exit
else
  echo -e "\e[92mBad Error Message Protection is enabled on active kernel."
fi

echo 

echo -e "\e[96m>> Checking if RFC-recommended Source Route Validation is enabled.."
signature=$(grep -cP '^net\.ipv4\.conf\.all\.rp_filter=1$' /etc/sysctl.conf)
if [ $signature -eq 0 ];
then
  echo -e "\e[91mRFC-recommended Source Route Validation (all) is not enabled..\e[39m"
  #exit
else
  echo -e "\e[92mRFC-recommended Source Route Validation (all) is enabled."
fi

signature=$(grep -cP '^net\.ipv4\.conf\.default\.rp_filter=1$' /etc/sysctl.conf)
if [ $signature -eq 0 ];
then
  echo -e "\e[91mRFC-recommended Source Route Validation (default) is not enabled..\e[39m"
  #exit
else
  echo -e "\e[92mRFC-recommended Source Route Validation (default) is enabled."
fi

signature=$(sysctl net.ipv4.conf.all.rp_filter| grep -cP '^net\.ipv4\.conf\.all\.rp_filter\s=\s1$')
if [ $signature -eq 0 ];
then
  echo -e "\e[91mRFC-recommended Source Route Validation (all) is not enabled on active kernel..\e[39m"
  #exit
else
  echo -e "\e[92mRFC-recommended Source Route Validation (all) is enabled on active kernel."
fi

signature=$(sysctl net.ipv4.conf.default.rp_filter| grep -cP '^net\.ipv4\.conf\.default\.rp_filter\s=\s1$')
if [ $signature -eq 0 ];
then
  echo -e "\e[91mRFC-recommended Source Route Validation (default) is not enabled on active kernel..\e[39m"
  #exit
else
  echo -e "\e[92mRFC-recommended Source Route Validation (default) is enabled on active kernel."
fi

echo 

echo -e "\e[96m>> Checking if TCP SYN Cookies is enabled.."
signature=$(grep -cP '^net\.ipv4\.tcp_syncookies=1$' /etc/sysctl.conf)
if [ $signature -eq 0 ];
then
  echo -e "\e[91mTCP SYN Cookies is not enabled..\e[39m"
  #exit
else
  echo -e "\e[92mTCP SYN Cookies is enabled."
fi

signature=$(sysctl net.ipv4.tcp_syncookies| grep -cP '^net\.ipv4\.tcp_syncookies\s=\s1$')
if [ $signature -eq 0 ];
then
  echo -e "\e[91mTCP SYN Cookies is not enabled on active kernel..\e[39m"
  #exit
else
  echo -e "\e[92mTCP SYN Cookies is enabled on active kernel."
fi

echo 

echo -e "\e[96m>> Checking TCP Wrappers installation.."
installed=$(dpkg-query -W -f='${Status}' tcpd 2>/dev/null | grep -c "ok installed")
if [ $installed -eq 0 ];
then
  echo -e "\e[91mtcpd is not installed..\e[39m"
  #exit
else
  echo -e "\e[92mtcpd is already installed."
fi

echo 

echo -e "\e[96m>> Checking /etc/hosts.allow.."
fileowner=$(ls -l /etc/hosts.allow| awk '{ print $3 }'|grep -c root)
if [ $fileowner -eq 0 ];
then
  echo -e "\e[91m/etc/hosts.allow is not owned by root..\e[39m"
  #exit
else
  echo -e "\e[92m/etc/hosts.allow is owned by root."
fi

filegroup=$(ls -l /etc/hosts.allow| awk '{ print $4 }'|grep -c root)
if [ $filegroup -eq 0 ];
then
  echo -e "\e[91m/etc/hosts.allow group is not root..\e[39m"
  #exit
else
  echo -e "\e[92m/etc/hosts.allow group is root."
fi

fileperms=$(stat --format '%a' /etc/hosts.allow|grep -c 644)
if [ $fileperms -eq 0 ];
then
  echo -e "\e[91m/etc/hosts.allow permissions are not 644..\e[39m"
  #exit
else
  echo -e "\e[92m/etc/hosts.allow permissions are 644."
fi

echo 

echo -e "\e[96m>> Checking /etc/hosts.deny.."
fileowner=$(ls -l /etc/hosts.deny| awk '{ print $3 }'|grep -c root)
if [ $fileowner -eq 0 ];
then
  echo -e "\e[91m/etc/hosts.deny is not owned by root..\e[39m"
  #exit
else
  echo -e "\e[92m/etc/hosts.deny is owned by root."
fi

filegroup=$(ls -l /etc/hosts.deny| awk '{ print $4 }'|grep -c root)
if [ $filegroup -eq 0 ];
then
  echo -e "\e[91m/etc/hosts.deny group is not root..\e[39m"
  #exit
else
  echo -e "\e[92m/etc/hosts.deny group is root."
fi

fileperms=$(stat --format '%a' /etc/hosts.deny|grep -c 644)
if [ $fileperms -eq 0 ];
then
  echo -e "\e[91m/etc/hosts.deny permissions are not 644..\e[39m"
  #exit
else
  echo -e "\e[92m/etc/hosts.deny permissions are 644."
fi

echo -e "\e[39m"

