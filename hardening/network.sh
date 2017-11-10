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



# Disable IP forwarding
sed -i "s/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=0/" /etc/sysctl.conf
sysctl -w net.ipv4.ip_forward=0

# Disable packet redirect sending
sed -i "/net.ipv4.conf.all.send_redirects.*/s/^#//g" /etc/sysctl.conf
echo "net.ipv4.conf.default.send_redirects=0" >> /etc/sysctl.conf
sysctl -w net.ipv4.conf.all.send_redirects=0
sysctl -w net.ipv4.conf.default.send_redirects=0

# Disable source routed packets
sed -i "/net.ipv4.conf.all.accept_source_route.*/s/^#//g" /etc/sysctl.conf
echo "net.ipv4.conf.default.accept_source_route=0" >> /etc/sysctl.conf
sysctl -w net.ipv4.conf.all.accept_source_route=0
sysctl -w net.ipv4.conf.default.accept_source_route=0

# Disable ICMP redirects
sed -i "/net.ipv4.conf.all.accept_redirects.*/s/^#//g" /etc/sysctl.conf
echo "net.ipv4.conf.default.accept_redirects=0" >> /etc/sysctl.conf
sysctl -w net.ipv4.conf.all.accept_redirects=0
sysctl -w net.ipv4.conf.default.accept_redirects=0

# Disable secure ICMP redirects
sed -i "/ net.ipv4.conf.all.secure_redirects.*/s/^# //g" /etc/sysctl.conf
echo "net.ipv4.conf.default.secure_redirects=0" >> /etc/sysctl.conf
sysctl -w net.ipv4.conf.all.secure_redirects=0
sysctl -w net.ipv4.conf.default.secure_redirects=0

# Log suspicious packets
sed -i "/net.ipv4.conf.all.log_martians.*/s/^#//g" /etc/sysctl.conf
echo "net.ipv4.conf.default.log_martians=1" >> /etc/sysctl.conf
sysctl -w net.ipv4.conf.all.log_martians=1
sysctl -w net.ipv4.conf.default.log_martians=1

# Ignore broadcast ICMP requests
echo "net.ipv4.icmp_echo_ignore_broadcasts=1" >> /etc/sysctl.conf
sysctl -w net.ipv4.icmp_echo_ignore_broadcasts=1

# Enable Bad Error Message Protection
echo "net.ipv4.icmp_ignore_bogus_error_responses=1" >> /etc/sysctl.conf
sysctl -w net.ipv4.icmp_ignore_bogus_error_responses=1

# Enable RFC-recommended Source Route Validation
sed -i "/net.ipv4.conf.all.rp_filter.*/s/^#//g" /etc/sysctl.conf
sed -i "/net.ipv4.conf.default.rp_filter.*/s/^#//g" /etc/sysctl.conf
sysctl -w net.ipv4.conf.all.rp_filter=1
sysctl -w net.ipv4.conf.default.rp_filter=1

# Enable TCP SYN Cookies
sed -i "/net.ipv4.tcp_syncookies.*/s/^#//g" /etc/sysctl.conf
sysctl -w net.ipv4.tcp_syncookies=1

# Install TCP Wrappers
apt -y install tcpd

chown root:root /etc/hosts.allow
chmod 644 /etc/hosts.allow
chown root:root /etc/hosts.deny
chmod 644 /etc/hosts.deny

sysctl -w net.ipv4.route.flush=1
