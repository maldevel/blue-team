#!/bin/bash

#
# GPLv3
# Twelvesec (c) Copyright 2019
# Debian 9 new installed default system
# @maldevel
# v0.2.1
#

if [[ "$EUID" -ne 0 ]]; then
  echo "Please run this script as root." 1>&2
  exit 1
fi

# 1.8 Ensure updates, patches, and additional security software are installed

apt update
apt upgrade -y


# 6.2.8 Ensure users' home directories permissions are 750 or more restrictive

chmod 0750 /var/run/dbus
chmod 0750 /run/sshd
chmod 0750 /run/systemd
chmod 0750 /run/systemd/netif
chmod 0750 /home/user


# 5.2.15 Ensure only strong Key Exchange algorithms are used

cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
printf '\n%s' 'KexAlgorithms curve25519-sha256,curve25519-sha256@libssh.org,diffie-hellman-group14-sha256,diffie-hellman-group16-sha512,diffie-hellman-group18-sha512,ecdh-sha2-nistp521,ecdh-sha2-nistp384,ecdh-sha2-nistp256,diffie-hellman-group-exchange-sha256' >>  /etc/ssh/sshd_config
printf '\n%s' 'macs umac-64-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512-etm@openssh.com,hmac-sha1-etm@openssh.com,umac-64@openssh.com,umac-128@openssh.com,hmac-sha2-256,hmac-sha2-512,hmac-sha1' >>  /etc/ssh/sshd_config
printf '\n%s\n' 'ciphers chacha20-poly1305@openssh.com,aes128-ctr,aes192-ctr,aes256-ctr,aes128-gcm@openssh.com,aes256-gcm@openssh.com' >>  /etc/ssh/sshd_config
systemctl restart ssh


# 6.1.9 Ensure permissions on /etc/gshadow- are configured


chown root:shadow /etc/gshadow-
chmod o-rwx,g-rw /etc/gshadow-


# 6.1.7 Ensure permissions on /etc/shadow- are configured


chown root:shadow /etc/shadow-
chmod o-rwx,g-rw /etc/shadow-


# 5.6 Ensure access to the su command is restricted - /etc/pam.d/su

cp /etc/pam.d/su /etc/pam.d/su.bak
groupadd wheel
sed -i "s/#.*auth.*required.*pam_wheel\.so$/auth required pam_wheel\.so group=wheel debug/" /etc/pam.d/su
printf '\n%s\n' '%wheel  ALL=(ALL:ALL) ALL' >> /etc/sudoers


# 5.5 Ensure root login is restricted to system console

cp /etc/securetty /etc/securetty.bak
echo > /etc/securetty


# 5.4.4 Ensure default user umask is 027 or more restrictive


cp /etc/bash.bashrc /etc/bash.bashrc.bak
cp /etc/profile /etc/profile.bak
printf '\n%s\n' 'umask 027' >> /etc/bash.bashrc
printf '\n%s\n' 'umask 027' >> /etc/profile


# 5.4.1.4 Ensure inactive password lock is 30 days or less


useradd -D -f 30
for user in `egrep ^[^:]+:[^\!*] /etc/shadow | cut -d: -f1`; do chage --inactive 30 $user; done


# 5.4.1.2 Ensure minimum days between password changes is 7 or more
# 5.4.1.1 Ensure password expiration is 365 days or less
# 5.4.1.3 Ensure password expiration warning days is 7 or more

cp /etc/login.defs /etc/login.defs.bak
sed -i "s/^PASS_MIN_DAYS.*/PASS_MIN_DAYS   7/" /etc/login.defs
sed -i "s/^PASS_MAX_DAYS.*/PASS_MAX_DAYS   90/" /etc/login.defs
sed -i "s/^PASS_WARN_AGE.*/PASS_WARN_AGE   10/" /etc/login.defs


# 5.3.3 Ensure password reuse is limited


cp /etc/pam.d/common-password /etc/pam.d/common-password.bak
printf '\n%s\n' 'password required pam_pwhistory.so remember=5' >> /etc/pam.d/common-password


# 5.3.2 Ensure lockout for failed password attempts is configured


cp /etc/pam.d/common-auth /etc/pam.d/common-auth.bak
printf '\n%s\n' 'auth required pam_tally2.so onerr=fail audit silent deny=5 unlock_time=900' >> /etc/pam.d/common-auth


# 5.3.1 Ensure password creation requirements are configured


apt install libpam-pwquality -y
# cp /etc/pam.d/common-password /etc/pam.d/common-password.bak
# printf '\n%s\n' 'password requisite pam_pwquality.so retry=3' >> /etc/pam.d/common-password
cp /etc/security/pwquality.conf /etc/security/pwquality.conf.bak
printf '\n%s' 'minlen = 14' >> /etc/security/pwquality.conf
printf '\n%s' 'dcredit = -1' >> /etc/security/pwquality.conf
printf '\n%s' 'ucredit = -1' >> /etc/security/pwquality.conf
printf '\n%s' 'ocredit = -1' >> /etc/security/pwquality.conf
printf '\n%s\n' 'lcredit = -1' >> /etc/security/pwquality.conf


# 5.2.9 Ensure SSH HostbasedAuthentication is disabled
# 5.2.8 Ensure SSH IgnoreRhosts is enabled
# 5.2.7 Ensure SSH MaxAuthTries is set to 4 or less
# 5.2.5 Ensure SSH LogLevel is appropriate
# 5.2.4 Ensure SSH Protocol is set to 2
# 5.2.19 Ensure SSH warning banner is configured
# 5.2.18 Ensure SSH access is limited
# 5.2.17 Ensure SSH LoginGraceTime is set to one minute or less
# 5.2.16 Ensure SSH Idle Timeout Interval is configured
# 5.2.12 Ensure SSH PermitUserEnvironment is disabled
# 5.2.11 Ensure SSH PermitEmptyPasswords is disabled
# 5.2.10 Ensure SSH root login is disabled
# 5.2.1 Ensure permissions on /etc/ssh/sshd_config are configured

cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
sed -i "s/#Port 22/Port 62111/g" /etc/ssh/sshd_config
sed -i "s/#HostbasedAuthentication.*no$/HostbasedAuthentication no/" /etc/ssh/sshd_config
sed -i "s/#IgnoreRhosts.*yes$/IgnoreRhosts yes/" /etc/ssh/sshd_config
sed -i "s/#MaxAuthTries.*6$/MaxAuthTries 4/" /etc/ssh/sshd_config
sed -i "s/#LogLevel.*INFO$/LogLevel INFO/" /etc/ssh/sshd_config
printf '\n%s' 'Protocol 2' >> /etc/ssh/sshd_config
cp /etc/issue.net /etc/issue.net.bak
echo "Welcome" > /etc/issue.net
printf '\n%s\n' 'Banner /etc/issue.net' >> /etc/ssh/sshd_config
sed -i "s/#LoginGraceTime.*2m$/LoginGraceTime 60/" /etc/ssh/sshd_config
sed -i "s/#ClientAliveInterval.*0$/ClientAliveInterval 300/" /etc/ssh/sshd_config
sed -i "s/#ClientAliveCountMax.*3$/ClientAliveCountMax 0/" /etc/ssh/sshd_config
sed -i "s/#PermitUserEnvironment.*no$/PermitUserEnvironment no/" /etc/ssh/sshd_config
sed -i "s/#PermitEmptyPasswords.*no$/PermitEmptyPasswords no/" /etc/ssh/sshd_config
sed -i "s/#PermitRootLogin.*prohibit-password/PermitRootLogin no/g" /etc/ssh/sshd_config
chown root:root /etc/ssh/sshd_config
chmod og-rwx /etc/ssh/sshd_config


# 5.1.8 Ensure at/cron is restricted to authorized users


touch /etc/cron.allow
touch /etc/at.allow
chmod og-rwx /etc/cron.allow
chmod og-rwx /etc/at.allow
chown root:root /etc/cron.allow
chown root:root /etc/at.allow


# 5.1.7 Ensure permissions on /etc/cron.d are configured


chown root:root /etc/cron.d
chmod og-rwx /etc/cron.d


# 5.1.6 Ensure permissions on /etc/cron.monthly are configured


chown root:root /etc/cron.monthly
chmod og-rwx /etc/cron.monthly


# 5.1.5 Ensure permissions on /etc/cron.weekly are configured


chown root:root /etc/cron.weekly
chmod og-rwx /etc/cron.weekly


# 5.1.4 Ensure permissions on /etc/cron.daily are configured


chown root:root /etc/cron.daily
chmod og-rwx /etc/cron.daily


# 5.1.3 Ensure permissions on /etc/cron.hourly are configured


chown root:root /etc/cron.hourly
chmod og-rwx /etc/cron.hourly


# 5.1.2 Ensure permissions on /etc/crontab are configured


chown root:root /etc/crontab
chmod og-rwx /etc/crontab


# 4.2.4 Ensure permissions on all logfiles are configured


chmod -R g-wx,o-rwx /var/log/*


# Local Host Firewall


apt -y install iptables-persistent
systemctl enable netfilter-persistent
iptables -F
iptables -X
iptables -Z

# Βlock null packets (DoS)
iptables -A INPUT -p tcp --tcp-flags ALL NONE -j DROP
# Block syn-flood attacks (DoS)
iptables -A INPUT -p tcp ! --syn -m state --state NEW -j DROP
# Block XMAS packets (DoS)
iptables -A INPUT -p tcp --tcp-flags ALL ALL -j DROP
# Allow internal traffic on the loopback device
iptables -A INPUT -i lo -j ACCEPT
# Allow HTTP/s access
iptables -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 443 -j ACCEPT
# Allow ssh access
iptables -A INPUT -p tcp -m tcp --dport 62111 -j ACCEPT
# Allow established connections
iptables -I INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT


# 3.5.2.1 Ensure IPv6 default deny firewall policy

ip6tables -F
ip6tables -X
ip6tables -Z

ip6tables -P INPUT DROP
ip6tables -P OUTPUT DROP
ip6tables -P FORWARD DROP


# 3.5.1.1 Ensure default deny firewall policy


iptables -P INPUT DROP
iptables -P OUTPUT ACCEPT
iptables -P FORWARD DROP


iptables-save > /etc/iptables/rules.v4
ip6tables-save > /etc/iptables/rules.v6


# 3.4.4 Ensure TIPC is disabled


cp /etc/modprobe.d/tipc.conf /etc/modprobe.d/tipc.conf.bak
printf '\n%s\n' 'install tipc /bin/true' >> /etc/modprobe.d/tipc.conf


# 3.4.3 Ensure RDS is disabled


cp /etc/modprobe.d/rds.conf /etc/modprobe.d/rds.conf.bak
printf '\n%s\n' 'install rds /bin/true' >> /etc/modprobe.d/rds.conf


# 3.4.2 Ensure SCTP is disabled


cp /etc/modprobe.d/sctp.conf /etc/modprobe.d/sctp.conf.bak
printf '\n%s\n' 'install sctp /bin/true' >> /etc/modprobe.d/sctp.conf


# 3.4.1 Ensure DCCP is disabled


cp /etc/modprobe.d/dccp.conf /etc/modprobe.d/dccp.conf.bak
printf '\n%s\n' 'install dccp /bin/true' >> /etc/modprobe.d/dccp.conf


# 3.2.9 Ensure IPv6 router advertisements are not accepted
# 3.2.8 Ensure TCP SYN Cookies is enabled
# 3.2.7 Ensure Reverse Path Filtering is enabled
# 3.2.6 Ensure bogus ICMP responses are ignored
# 3.2.5 Ensure broadcast ICMP requests are ignored
# 3.2.3 Ensure secure ICMP redirects are not accepted
# 3.2.2 Ensure ICMP redirects are not accepted
# 3.2.1 Ensure source routed packets are not accepted
# 3.1.2 Ensure packet redirect sending is disabled
# 3.1.1 Ensure IP forwarding is disabled


cp /etc/sysctl.d/99-sysctl.conf /etc/sysctl.d/99-sysctl.conf.bak
printf '\n%s\n' 'net.ipv6.conf.all.accept_ra = 0' >> /etc/sysctl.d/99-sysctl.conf
printf '\n%s\n' 'net.ipv6.conf.default.accept_ra = 0' >> /etc/sysctl.d/99-sysctl.conf
sysctl -w net.ipv6.conf.all.accept_ra=0
sysctl -w net.ipv6.conf.default.accept_ra=0
sed -i "s/#net.ipv4.tcp_syncookies=1/net.ipv4.tcp_syncookies=1/g" /etc/sysctl.d/99-sysctl.conf
sysctl -w net.ipv4.tcp_syncookies=1
sed -i "s/#net.ipv4.conf.all.rp_filter=1/net.ipv4.conf.all.rp_filter=1/g" /etc/sysctl.d/99-sysctl.conf
sed -i "s/#net.ipv4.conf.default.rp_filter=1/net.ipv4.conf.default.rp_filter=1/g" /etc/sysctl.d/99-sysctl.conf
sysctl -w net.ipv4.conf.all.rp_filter=1
sysctl -w net.ipv4.conf.default.rp_filter=1
printf '\n%s\n' 'net.ipv4.icmp_ignore_bogus_error_responses = 1' >> /etc/sysctl.d/99-sysctl.conf
sysctl -w net.ipv4.icmp_ignore_bogus_error_responses=1
printf '\n%s\n' 'net.ipv4.icmp_echo_ignore_broadcasts = 1' >> /etc/sysctl.d/99-sysctl.conf
sysctl -w net.ipv4.icmp_echo_ignore_broadcasts=1
sed -i "s/#net.ipv4.conf.all.log_martians.*=.*1/net.ipv4.conf.all.log_martians = 1/g" /etc/sysctl.d/99-sysctl.conf
printf '\n%s\n' 'net.ipv4.conf.default.log_martians = 1' >> /etc/sysctl.d/99-sysctl.conf
sysctl -w net.ipv4.conf.all.log_martians=1
sysctl -w net.ipv4.conf.default.log_martians=1
sed -i "s/# net.ipv4.conf.all.secure_redirects.*=.*1/net.ipv4.conf.all.secure_redirects = 0/g" /etc/sysctl.d/99-sysctl.conf
printf '\n%s\n' 'net.ipv4.conf.default.secure_redirects = 0' >> /etc/sysctl.d/99-sysctl.conf
sysctl -w net.ipv4.conf.all.secure_redirects=0
sysctl -w net.ipv4.conf.default.secure_redirects=0
sed -i "s/#net.ipv4.conf.all.accept_redirects.*=.*0/net.ipv4.conf.all.accept_redirects = 0/g" /etc/sysctl.d/99-sysctl.conf
printf '\n%s\n' 'net.ipv4.conf.default.accept_redirects = 0' >> /etc/sysctl.d/99-sysctl.conf
sed -i "s/#net.ipv6.conf.all.accept_redirects.*=.*0/net.ipv6.conf.all.accept_redirects = 0/g" /etc/sysctl.d/99-sysctl.conf
printf '\n%s\n' 'net.ipv6.conf.default.accept_redirects = 0' >> /etc/sysctl.d/99-sysctl.conf
sysctl -w net.ipv4.conf.all.accept_redirects=0
sysctl -w net.ipv4.conf.default.accept_redirects=0
sysctl -w net.ipv6.conf.all.accept_redirects=0
sysctl -w net.ipv6.conf.default.accept_redirects=0
sed -i "s/#net.ipv4.conf.all.accept_source_route.*=.*0/net.ipv4.conf.all.accept_source_route = 0/g" /etc/sysctl.d/99-sysctl.conf
printf '\n%s\n' 'net.ipv4.conf.default.accept_source_route = 0' >> /etc/sysctl.d/99-sysctl.conf
sed -i "s/#net.ipv6.conf.all.accept_source_route.*=.*0/net.ipv6.conf.all.accept_source_route = 0/g" /etc/sysctl.d/99-sysctl.conf
printf '\n%s\n' 'net.ipv6.conf.default.accept_source_route = 0' >> /etc/sysctl.d/99-sysctl.conf
sysctl -w net.ipv4.conf.all.accept_source_route=0
sysctl -w net.ipv4.conf.default.accept_source_route=0
sysctl -w net.ipv6.conf.all.accept_source_route=0
sysctl -w net.ipv6.conf.default.accept_source_route=0
sed -i "s/#net.ipv4.conf.all.send_redirects.*=.*0/net.ipv4.conf.all.send_redirects = 0/g" /etc/sysctl.d/99-sysctl.conf
printf '\n%s\n' 'net.ipv4.conf.default.send_redirects = 0' >> /etc/sysctl.d/99-sysctl.conf
sysctl -w net.ipv4.conf.all.send_redirects=0
sysctl -w net.ipv4.conf.default.send_redirects=0
sed -i "s/#net.ipv4.ip_forward=1/net.ipv4.ip_forward = 0/g" /etc/sysctl.d/99-sysctl.conf
sed -i "s/#net.ipv6.conf.all.forwarding=1/net.ipv6.conf.all.forwarding = 0/g" /etc/sysctl.d/99-sysctl.conf
sysctl -w net.ipv4.ip_forward=0
sysctl -w net.ipv6.conf.all.forwarding=0

sysctl -w net.ipv4.route.flush=1
sysctl -w net.ipv6.route.flush=1


# 2.2.2 Ensure X Window System is not installed


apt-get remove xserver-xorg*


# 1.7.1.2 Ensure local login warning banner is configured properly


 echo "Welcome" > /etc/issue


 # 1.7.1.1 Ensure message of the day is configured properly


 echo "Welcome" > /etc/motd


 # 1.5.1 Ensure core dumps are restricted


cp /etc/security/limits.conf /etc/security/limits.conf.bak
cp /etc/sysctl.d/99-sysctl.conf /etc/sysctl.d/99-sysctl.conf.bak2
printf '\n%s\n' '* hard core 0' >> /etc/security/limits.conf
printf '\n%s\n' 'fs.suid_dumpable = 0' >> /etc/sysctl.d/99-sysctl.conf
sysctl -w fs.suid_dumpable=0


# 1.4.1 Ensure permissions on bootloader config are configured


chown root:root /boot/grub/grub.cfg
chmod og-rwx /boot/grub/grub.cfg


# 1.1.1.5 Ensure mounting of udf filesystems is disabled


cp /etc/modprobe.d/udf.conf /etc/modprobe.d/udf.conf.bak
printf '\n%s\n' 'install udf /bin/true' >> /etc/modprobe.d/udf.conf
rmmod udf


# 1.1.1.4 Ensure mounting of hfsplus filesystems is disabled


cp /etc/modprobe.d/hfsplus.conf /etc/modprobe.d/hfsplus.conf.bak
printf '\n%s\n' 'install hfsplus /bin/true' >> /etc/modprobe.d/hfsplus.conf
rmmod hfsplus


# 1.1.1.3 Ensure mounting of hfs filesystems is disabled


cp /etc/modprobe.d/hfs.conf /etc/modprobe.d/hfs.conf.bak
printf '\n%s\n' 'install hfs /bin/true' >> /etc/modprobe.d/hfs.conf
rmmod hfs


# 1.1.1.2 Ensure mounting of jffs2 filesystems is disabled


cp /etc/modprobe.d/jffs2.conf /etc/modprobe.d/jffs2.conf.bak
printf '\n%s\n' 'install jffs2 /bin/true' >> /etc/modprobe.d/jffs2.conf
rmmod jffs2


# 1.1.1.1 Ensure mounting of freevxfs filesystems is disabled


cp /etc/modprobe.d/freevxfs.conf /etc/modprobe.d/freevxfs.conf.bak
printf '\n%s\n' 'install freevxfs /bin/true' >> /etc/modprobe.d/freevxfs.conf
rmmod freevxfs

