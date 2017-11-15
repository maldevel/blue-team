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



# Set /etc/passwd ownership and access permissions.
chown root:root /etc/passwd
chmod 644 /etc/passwd

# Set /etc/shadow ownership and access permissions.
chown root:shadow /etc/shadow
chmod 640 /etc/shadow

# Set /etc/group ownership and access permissions.
chown root:root /etc/group
chmod 644 /etc/group

# Set /etc/gshadow ownership and access permissions.
chown root:shadow /etc/gshadow
chmod 640 /etc/group

# Set /etc/security/opasswd ownership and access permissions.
chown root:root /etc/security/opasswd
chmod 600 /etc/security/opasswd

# Set /etc/passwd- ownership and access permissions.
chown root:root /etc/passwd-
chmod 600 /etc/passwd-

# Set /etc/shadow- ownership and access permissions.
chown root:root /etc/shadow-
chmod 600 /etc/shadow-

# Set /etc/group- ownership and access permissions.
chown root:root /etc/group-
chmod 600 /etc/group-

# Set /etc/gshadow- ownership and access permissions.
chown root:root /etc/gshadow-
chmod 600 /etc/gshadow-

