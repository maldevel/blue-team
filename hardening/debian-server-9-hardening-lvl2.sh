#!/bin/bash

#    This file is part of blue-team
#    Copyright (C) 2019 @maldevel
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

#
# GPLv3
# Debian 9 new installed default system - Lvl2
# @maldevel
# v0.1
#


if [[ "$EUID" -ne 0 ]]; then
  echo "Please run this script as root." 1>&2
  exit 1
fi


# 5.4.5 Ensure default user shell timeout is 900 seconds or less


cp /etc/bash.bashrc /etc/bash.bashrc.bak
cp /etc/profile /etc/profile.bak

tmoutbash=$(grep -cP '^TMOUT=600$' /etc/bash.bashrc)
if [ $tmoutbash -eq 0 ];
then
	printf '\n%s\n' 'TMOUT=600' >> /etc/bash.bashrc
fi

tmoutprof=$(grep -cP '^TMOUT=600$' /etc/profile)
if [ $tmoutprof -eq 0 ];
then
	printf '\n%s\n' 'TMOUT=600' >> /etc/profile
fi


# 5.2.6 Ensure SSH X11 forwarding is disabled


cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
sed -i "s/^X11Forwarding.*yes/X11Forwarding no/" /etc/ssh/sshd_config


# Disable IPv6


cp /etc/default/grub /etc/default/grub.bak
sed -i "s/^GRUB_CMDLINE_LINUX=\"\"/GRUB_CMDLINE_LINUX=\"ipv6.disable=1\"/" /etc/default/grub
update-grub

