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
echo -e "\e[1;95m-------------------------[network audit in progress]-------------------------"

signature=$(grep -cP '^net\.ipv4\.ip_forward=0$' /etc/sysctl.conf)
if [ $signature -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking if IP forwarding is disabled\t\t\t\t\t\t$status"

signature=$(sysctl net.ipv4.ip_forward| grep -cP '^net\.ipv4\.ip_forward\s=\s0$')
if [ $signature -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking if IP forwarding is disabled for active kernel\t\t\t\t$status"

signature=$(grep -cP '^net\.ipv4\.conf\.all\.send_redirects\s=\s0$' /etc/sysctl.conf)
if [ $signature -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking if packet redirect is disabled (all)\t\t\t\t\t$status"

signature=$(grep -cP '^net\.ipv4\.conf\.default\.send_redirects=0$' /etc/sysctl.conf)
if [ $signature -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking if packet redirect is disabled (default)\t\t\t\t\t$status"

signature=$(sysctl net.ipv4.conf.all.send_redirects| grep -cP '^net\.ipv4\.conf\.all\.send_redirects\s=\s0$')
if [ $signature -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking if packet redirect is disabled for active kernel (all)\t\t\t$status"

signature=$(sysctl net.ipv4.conf.default.send_redirects| grep -cP '^net\.ipv4\.conf\.default\.send_redirects\s=\s0$')
if [ $signature -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking if packet redirect is disabled for active kernel (default)\t\t\t$status"

signature=$(grep -cP '^net\.ipv4\.conf\.all\.accept_source_route\s=\s0$' /etc/sysctl.conf)
if [ $signature -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking if source routed packets is disabled (all)\t\t\t\t\t$status"

signature=$(grep -cP '^net\.ipv4\.conf\.default\.accept_source_route=0$' /etc/sysctl.conf)
if [ $signature -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking if source routed packets is disabled (default)\t\t\t\t$status"

signature=$(sysctl net.ipv4.conf.all.accept_source_route| grep -cP '^net\.ipv4\.conf\.all\.accept_source_route\s=\s0$')
if [ $signature -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking if source routed packets are disabled for active kernel (all)\t\t$status"

signature=$(sysctl net.ipv4.conf.default.accept_source_route| grep -cP '^net\.ipv4\.conf\.default\.accept_source_route\s=\s0$')
if [ $signature -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking if source routed packets are disabled for active kernel (default)\t\t$status"

signature=$(grep -cP '^net\.ipv4\.conf\.all\.accept_redirects\s=\s0$' /etc/sysctl.conf)
if [ $signature -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking if ICMP redirects are disabled (all)\t\t\t\t\t$status"

signature=$(grep -cP '^net\.ipv4\.conf\.default\.accept_redirects=0$' /etc/sysctl.conf)
if [ $signature -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking if ICMP redirects are disabled (default)\t\t\t\t\t$status"

signature=$(sysctl net.ipv4.conf.all.accept_redirects| grep -cP '^net\.ipv4\.conf\.all\.accept_redirects\s=\s0$')
if [ $signature -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking if ICMP redirects are disabled for active kernel (all)\t\t\t$status"

signature=$(sysctl net.ipv4.conf.default.accept_redirects| grep -cP '^net\.ipv4\.conf\.default\.accept_redirects\s=\s0$')
if [ $signature -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking if ICMP redirects are disabled for active kernel (default)\t\t\t$status"

signature=$(grep -cP '^net\.ipv4\.conf\.all\.log_martians\s=\s1$' /etc/sysctl.conf)
if [ $signature -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking if suspicious packets logging is enabled (all)\t\t\t\t$status"

signature=$(grep -cP '^net\.ipv4\.conf\.default\.log_martians=1$' /etc/sysctl.conf)
if [ $signature -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking if suspicious packets logging is enabled (default)\t\t\t\t$status"

signature=$(sysctl net.ipv4.conf.all.log_martians| grep -cP '^net\.ipv4\.conf\.all\.log_martians\s=\s1$')
if [ $signature -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking if suspicious packets logging is enabled for active kernel (all)\t\t$status"

signature=$(sysctl net.ipv4.conf.default.log_martians| grep -cP '^net\.ipv4\.conf\.default\.log_martians\s=\s1$')
if [ $signature -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking if suspicious packets logging is enabled for active kernel (default)\t$status"

signature=$(grep -cP '^net\.ipv4\.icmp_echo_ignore_broadcasts=1$' /etc/sysctl.conf)
if [ $signature -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking if broadcast ICMP requests are ignored\t\t\t\t\t$status"

signature=$(sysctl net.ipv4.icmp_echo_ignore_broadcasts| grep -cP '^net\.ipv4\.icmp_echo_ignore_broadcasts\s=\s1$')
if [ $signature -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking if broadcast ICMP requests are ignored for active kernel\t\t\t$status"

signature=$(grep -cP '^net\.ipv4\.icmp_ignore_bogus_error_responses=1$' /etc/sysctl.conf)
if [ $signature -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking if Bad Error Message Protection is enabled\t\t\t\t\t$status"

signature=$(sysctl net.ipv4.icmp_ignore_bogus_error_responses| grep -cP '^net\.ipv4\.icmp_ignore_bogus_error_responses\s=\s1$')
if [ $signature -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking if Bad Error Message Protection is enabled for active kernel\t\t$status"

signature=$(grep -cP '^net\.ipv4\.conf\.all\.rp_filter=1$' /etc/sysctl.conf)
if [ $signature -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking if Source Route Validation is enabled (all)\t\t\t\t$status"

signature=$(grep -cP '^net\.ipv4\.conf\.default\.rp_filter=1$' /etc/sysctl.conf)
if [ $signature -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking if Source Route Validation is enabled (default)\t\t\t\t$status"

signature=$(sysctl net.ipv4.conf.all.rp_filter| grep -cP '^net\.ipv4\.conf\.all\.rp_filter\s=\s1$')
if [ $signature -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking if Source Route Validation is enabled for active kernel (all)\t\t$status"

signature=$(sysctl net.ipv4.conf.default.rp_filter| grep -cP '^net\.ipv4\.conf\.default\.rp_filter\s=\s1$')
if [ $signature -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking if Source Route Validation is enabled for active kernel (default)\t\t$status"

signature=$(grep -cP '^net\.ipv4\.tcp_syncookies=1$' /etc/sysctl.conf)
if [ $signature -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking if TCP SYN Cookies is enabled\t\t\t\t\t\t$status"

signature=$(sysctl net.ipv4.tcp_syncookies| grep -cP '^net\.ipv4\.tcp_syncookies\s=\s1$')
if [ $signature -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking if TCP SYN Cookies is enabled for active kernel\t\t\t\t$status"

installed=$(dpkg-query -W -f='${Status}' tcpd 2>/dev/null | grep -c "ok installed")
if [ $installed -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking TCP Wrappers installation\t\t\t\t\t\t\t$status"

fileowner=$(ls -l /etc/hosts.allow| awk '{ print $3 }'|grep -c root)
if [ $fileowner -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking /etc/hosts.allow owner\t\t\t\t\t\t\t$status"

filegroup=$(ls -l /etc/hosts.allow| awk '{ print $4 }'|grep -c root)
if [ $filegroup -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking /etc/hosts.allow group\t\t\t\t\t\t\t$status"

fileperms=$(stat --format '%a' /etc/hosts.allow|grep -c 644)
if [ $fileperms -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking /etc/hosts.allow file permissions\t\t\t\t\t\t$status"

fileowner=$(ls -l /etc/hosts.deny| awk '{ print $3 }'|grep -c root)
if [ $fileowner -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking /etc/hosts.deny owner\t\t\t\t\t\t\t$status"

filegroup=$(ls -l /etc/hosts.deny| awk '{ print $4 }'|grep -c root)
if [ $filegroup -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking /etc/hosts.deny group\t\t\t\t\t\t\t$status"

fileperms=$(stat --format '%a' /etc/hosts.deny|grep -c 644)
if [ $fileperms -eq 0 ];
then
  status="\e[91m[ BAD ]"
  #exit
else
  status="\e[92m[ GOOD ]"
fi
echo -e "\e[39m[*] Checking /etc/hosts.deny file permissions\t\t\t\t\t\t$status"

echo -e "\e[39m"

