# Linux & DevOps Snippets — Reference Guide
> Curated from your notes. Code is preserved exactly as provided.

## Table of Contents
- [System Basics](#system-basics)
  - [Shell & Logs](#shell--logs)
  - [Date & Time](#date--time)
  - [Package Management](#package-management)
  - [Boot & Recovery (GRUB)](#boot--recovery-grub)
  - [Text Processing](#text-processing)
  - [Editors](#editors)
- [User & Permissions](#user--permissions)
  - [User Management](#user-management)
  - [Groups](#groups)
  - [File Permissions & Ownership](#file-permissions--ownership)
  - [sudo](#sudo)
  - [SELinux](#selinux)
- [Process & Resource Management](#process--resource-management)
  - [Processes & Jobs](#processes--jobs)
  - [Performance & System Info](#performance--system-info)
  - [Services (systemd)](#services-systemd)
- [Networking](#networking)
  - [Interfaces & Autoconnect](#interfaces--autoconnect)
  - [IP & Routing](#ip--routing)
  - [SSH & Keys](#ssh--keys)
  - [HTTP & Curl](#http--curl)
  - [Firewall](#firewall)
- [Storage & Filesystem](#storage--filesystem)
  - [Disk & Partitions](#disk--partitions)
  - [LVM](#lvm)
  - [Filesystems & Mounts](#filesystems--mounts)
  - [File & Folder Ops](#file--folder-ops)
  - [Compression & Archiving](#compression--archiving)
  - [NFS](#nfs)
- [File Transfer & Remote Access](#file-transfer--remote-access)
  - [SCP & Rsync](#scp--rsync)
- [Databases](#databases)
  - [MariaDB / MySQL](#mariadb--mysql)
- [Automation & Scheduling](#automation--scheduling)
  - [Cron](#cron)
- [Services & Applications](#services--applications)
  - [Apache / Nginx](#apache--nginx)
  - [Samba](#samba)
  - [VSFTPD (FTP)](#vsftpd-ftp)
  - [Sublime Text](#sublime-text)
  - [CCTV](#cctv)
- [Uncategorized](#uncategorized)
  - [Misc](#misc)
---

## System Basics

### Shell & Logs
_Snippets related to **Shell & Logs**._

```bash
## add below
sam ALL=(ALL) NOPASSWD: ALL
```

```bash
sudo dnf install cockpit -y
sudo systemctl enable --now cockpit.socket
```

```bash
Find processes using more than 50% CPU
ps aux | awk '$3 > 50 {print $0}'
```

```bash
Filter processes belonging to a specific user consuming >10% memory
ps aux | awk '$1 == "user1" && $4 > 10 {print $0}'
```

```bash
# SSH WITH KEYFILE  
ssh -i ssh-key-2023-02-22.key opc@158.101.196.84
```

```bash
# VIEW LOGEED IN USERS  
w
```

```bash
# CHECK LOG tail 
/var/log/auth.log
```

```bash
# CALANDER WITH SPECIFIC MONTH  
cal oct 2020
```

```bash
# CURRENT TIME WITH WHICH USER USING THE SYSTEM 
uptime
```

```bash
# FILE SYSTEM SIZE WITH TYPE  
df -Th
```

```bash
# SORT BY FILE SIZE, WITH THE LARGEST FILES FIRST.
ls -lhS
```

```bash
# LIST ALL FILES WITH HIDDEN FILES  
ls -al
```

```bash
# LIST FILES WITH FILE PERMISSIONS  
ls -l
```

```bash
# LIST ALL FILES WITH HIDDEN FILES iN READABLE FORMAT 
ls -lsah
```

```bash
# LIST FILES WITH ORDER 
ls -lX
```

```bash
# LIST FILES WITH ACESS TIME  
ls -ult
```

```bash
# VIEW PERMISSIONS  
ls-l myfile
```

```bash
# QUICK ONFO ABOUNT COMMANDS  
whatis ls scp
```

```bash
## FILE SIZE  
du -h /var/lib/deluge/Downloads/
```

```bash
## WITH SUBDIRECTORY SIZES + MAIN FOLDER SIZE 
du -h
```

```bash
## LIST WITH SIZE 
du -sh * | sort -hr
```

```bash
# COPY WITH PROGRESS
rsync -ah --info=progress2 <source> <destination>
rsync -ah --info=progress2 --stats <source> <destination>
```

```bash
# TO COPY THE SOURCE DIRECTORY ITSELF (WITH THE FOLDER):
$ rsync -ah --info=progress myfolder target_d/
```

```bash
# TO COPY ONLY THE CONTENTS OF THE SOURCE DIRECTORY (WITHOUT THE FOLDER):
$ rsync -ah --info=progress2 myfolder/ target_d/
```

```bash
scp sam@cmsl-si:/var/www/remotely "C:/Users/uchithr/Downloads/D_DRIVE"
## VERIFYING IMAGE BY SHA
$ echo "fa95fb748b34d470a7cfa5e3c1c8fa1163e2dc340cd5a60f7ece9dc963ecdf88 \ *ubuntu-21.04-desktop-amd64.iso" | shasum -a 256 --check
```

```bash
## ACCESS WINDOWS PATH FROM LINUX
smbclient --user=sl/uchithr%apr@187*#  //slktweb/IT-Software
```

```bash
## COCKPIT	
yum install cockpit	
sudo firewall-cmd --add-service=cockpit	
sudo firewall-cmd --add-service=cockpit --permanent	
systemctl enable --now cockpit.socket	
systemctl start cockpit	
ss -tulpn | grep :9090
```

```bash
firewall-cmd --zone=public --add-port=9090/tcp --permanent	
firewall-cmd  --reload
```

```bash
## INSTALL GUI MODE TO CLI SERVER
$ dnf groupinstall "Server with GUI"
```

```bash
## GUI CLI SWITCH	
systemctl get-default	
yum install epel-release	
yum  groupinstall -y "KDE Plasma Workspaces"	
yum config-manager --set-enabled powertools
```

```bash
## PIP	
python3 -m pip show mutagen	
sudo yum install epel-release	
sudo yum install python-pip	
sudo pip3 install mutagen
```

```bash
## TERMINAL RECORD
script
exit
script my_terminal_session.txt
~/.bash_history
```

```bash
## DISABLE BASH HISTORY
nano ~/.bashrc
unset HISTFILE #Add the following line at the end of the file to disable history:
source ~/.bashrc #to apply
```

```bash
# RUN A STRESS TEST: 2 CPU WORKERS, 1 IO WORKER, 1 VM USING 128MB RAM FOR 10 SECONDS
stress --cpu 2 --io 1 --vm 1 --vm-bytes 128M --timeout 10s
```

```bash
### MEMORY AND DISK CACHE CLEANUP ###
#
# DELETE ALL PHP5 SESSION FILES (USE WITH CAUTION; PATH MAY VARY BY PHP VERSION)
sudo rm -rf /var/lib/php5/*
```

```bash
# -------------------------------------------------------------------------
### SERVICE MANAGEMENT & TROUBLESHOOTING ###
# 
# RESTART THE APACHE2 WEB SERVER
sudo systemctl restart apache2
```

```bash
# -------------------------------------------------------------------------
###  NETWORK MONITORING & DIAGNOSTICS ###
#
# DISPLAY LIVE INTERFACE BANDWIDTH USAGE
ifstat
```

```bash
# DISPLAY PACKET/TRAFFIC STATISTICS FOR ALL NETWORK INTERFACES
ip -s link
```

```bash
# GRAPHICAL REAL-TIME BANDWIDTH MONITOR PER INTERFACE
nload
```

```bash
# SHOW ACTIVE CONNECTIONS AND LISTENING PORTS WITH ASSOCIATED PROCESSES
ss -tunap
```

```bash
# RUN APACHE BENCHMARK WITH 100 REQUESTS AND 10 CONCURRENT USERS
ab -n 100 -c 10 http://your-server/
```

```bash
###  LOGS & SYSTEM EVENTS ##
#
# VIEW RECENT SYSTEM LOGS WITH EXTENDED INFORMATION (ERRORS, WARNINGS, ETC.)
journalctl -xe
```

```bash
# VIEW KERNEL AND HARDWARE-RELATED MESSAGES (SCROLLABLE)
dmesg | less
```

```bash
# SHOW CURRENTLY RUNNING QUERIES WITH FULL DETAILS (RUN INSIDE MYSQL SHELL)
SHOW FULL PROCESSLIST;
```

```bash
# CHECK LAST REBOOT TIME
last -x -F | grep -E "shutdown|reboot" | sort -k5,5M -k6,6n
```

```bash
nmcli connection add con-name NIC type Ethernet ifname eth0
nmcli connection modify NIC ipv4.addresses "172.25.8.11/24 172.25.0.254" ipv4.dns 172.25.254.254 ipv4.method static connection.autoconnect yes
nmcli connection down "System eth0" ; nmcli connection up NIC
```

```bash
## NETWORK AUTOCONNECT     #######################################################################################
```

```bash
# ENABLE NETWORKMANAGER SERVICE
sudo systemctl enable NetworkManager
sudo systemctl start NetworkManager
```

```bash
# CONFIGURE THE NETWORK INTERFACE
nmcli device
nmcli connection modify <interface> connection.autoconnect yes
nmcli connection show <interface>
```

```bash
# VERIFY NETWORKMANAGER CONFIGURATION
/etc/NetworkManager/system-connections/<interface>
```

```bash
#TEST AND REBOOT
sudo systemctl restart NetworkManager
sudo reboot
```

```bash
#  CHECK DNS FORM CMD
whois slvr.com
```

```bash
# ADD DNS NAME WITH IP
sudo vim /etc/hosts >> 10.0.0.198 slvr.site dns
```

```bash
# MULTIPLE LINES DELETION (deletes the current line and the next two lines)
$ 3dd
```

```bash
# LINEWISE SELECTION
$ Shit + V
```

```bash
#### WI-FI ####
```

```bash
# WLAN CONFIGS LOCATION
/etc/network/interfaces OR  /etc/wpa_supplicant/wpa_supplicant.conf
```

```bash
## WLAN SCAN
$ sudo iwlist wlan0 scan
```

```bash
## CONVERT WIFI PASSWORD TO HASH ## WPA2
$ wpa_passphrase <SSID> <password>     # wpa_passphrase MyWiFiNetwork 'mySecretPassword'
```

```bash
network={
    ssid="YourNetworkSSID"
    key_mgmt=SAE
    psk="<SAE password generated from the previous step>"
}
```

```bash
## LOGIN TO WIFI
$ sudo iwlist wlan0 scan
$ sudo nmcli device wifi connect <SSID> password <password>
$ sudo nmcli device disconnect wlan0
$ nmcli device status
```

```bash
## GENERATE  WI-FI QR
$ sudo dnf install qrencode
$ qrencode "WIFI:S:<SSID>;T:WPA;P:<PASSWORD>;;" -d=150 -s 30 -o file1.png
```

```bash
## WAKE ON LAN
$ sudo ethtool ens160 | grep -i wake-on
 if pumg doesnt shows use below to enable
$ sudo ethtool -s enp0s25 wol g
```

```bash
##PASSWORD RESET
```

```bash
# mount -o remount,rw /sysroot
# chroot /sysroot
# passwd root
# touch /.autorelabel
```

```bash
# RECOVERING AN OEM WINDOWS 8 OR 10 PRODUCT KEY
$ sudo cat /sys/firmware/acpi/tables/MSDM
MSDMU
DELL CBX3
AMI
FAKEP-RODUC-TKEY1-22222-33333
```

```bash
## TO TEMPORARILY DEACTIVATE AN ACCOUNT
$ sudo passwd -l stash
passwd: password expiry information changed.
```

```bash
## TO ACTIVATE AN ACCOUNT
$ sudo passwd -u stash
passwd: password expiry information changed
```

```bash
## TO COMPLETELY DISABLE A USER ACCOUNT (WHEN USING SSH KEYS)
$ sudo usermod --expiredate 1 stash
```

```bash
ll
-rw-rw-r--. 1 sam sam 0 Jan 28 06:28 myfile
```

```bash
chmod o+w myfile
```

```bash
ll
-rw-rw-rw-. 1 sam sam 0 Jan 28 06:28 myfile
```

```bash
sudo ls -ald /Finance/
drwxr-xr-x. 2 root root 6 Jan 28 12:36 /Finance/
```

```bash
id sam
uid=1001(sam) gid=1001(sam) groups=1001(sam),10(wheel)
```

```bash
id sam
uid=1001(sam) gid=1001(sam) groups=1001(sam),10(wheel),1002(HR)
---
```

```bash
sudo ls -ald /Finance/
drwxr-xr-x. 2 root HR 6 Jun 9 12:19 /Finance/
```

```bash
sudo chown sam myfile
sudo chown sam.HR myfile
```

```bash
ll
-rw-rw-rw-. 1 sam HR 0 Jan 28 06:28 myfile
```

```bash
sudo chgrp HR myfile
sudo chgrp hrgrp /HRDATA ## change root grop to hrgrp
sudo chmod g+w,o-wr /HRDATA ## remove other access
```

```bash
getfacl /HRDATA
# file: HRDATA
# owner: root
# group: hrgrp
user::rwx
group::rwx
other::--x
```

```bash
sudo setfacl -R -m u:sam:rwx /HRDATA ## SAM can access all files
sudo setfacl -x u:sam:rwx /HRDATA ## Remove execute feature from SAM
```

```bash
getfacl /HRDATA
# file: HRDATA
# owner: root
# group: hrgrp
user::rwx
user:sam:rwx
group::rwx
mask::rwx
other::--x
```

```bash
sudo setfacl -m g:itgrp:rwx /HRDATA ## itgrp can access all files
```

```bash
getfacl /HRDATA
# file: HRDATA
# owner: root
# group: hrgrp
user::rwx
user:sam:rwx
group::rwx
group:itgrp:rwx
mask::rwx
other::--x
```

```bash
sudo setfacl -R -m g:hrgrp:rwx /HRDATA ## For existing files
sudo setfacl -m g:hrgrp:rwx /HRDATA ## For new files
```

```bash
# firewall-cmd --zone=public --permanent --add-service=ssh
# firewall-cmd --reload
```

```bash
# ENSURE CORRECT OWNERSHIP
$ chown -R username:username ~/.ssh
```

```bash
# DISABLE PASSWORD AUTHENTICATION (on the server)
$ sudo nano /etc/ssh/sshd_config
```

```bash
# Update or add the following lines:
  PubkeyAuthentication yes                # Enable public key authentication #45
  AuthorizedKeysFile .ssh/authorized_keys # Specify the file with public keys #49
  PasswordAuthentication no               # Disable password authentication #65
```

```bash
$ Ctrl + O #writeout
$ Ctrl + X #exit
```

```bash
# IMPROVE SECURITY WITH FAIL2BAN (OPTIONAL)
$ sudo dnf install epel-release -y 
$ sudo dnf install fail2ban -y
$ sudo systemctl enable fail2ban
$ sudo systemctl start fail2ban
```

```bash
# ZIP FOLDER WITH ZERO COMPRESSION WITH 500M SPLIT	 (0-9)
zip -0 -r -s 500m output/myzip source/
```

```bash
# IF RAR ARCHIVE IS PASSWORD-PROTECTED:
unrar x -pPASSWORD file.rar
```

```bash
tar cvzf - test | split --bytes=15MB - name.tar.gz. [work]
```

```bash
####  VSFTPD FTP WITH SECURE CHROOT JAIL
```

```bash
# START AND ENABLE VSFTPD SERVICE
sudo systemctl enable --now vsftpd
```

```bash
# Allow local users to log in
local_enable=YES
```

```bash
# Allow FTP write commands
write_enable=YES
```

```bash
# Show directory messages
dirmessage_enable=YES
```

```bash
# SET PERMISSIONS AND HOME DIRECTORY
sudo mkdir /home/sam/ftp/files -p
sudo chmod a-w /home/sam/ftp
```

```bash
sudo chown nobody:nobody /home/sam/ftp
sudo chown sam:sam /home/sam/ftp/files
```

```bash
sudo firewall-cmd --permanent --add-port=21/tcp
sudo firewall-cmd --reload
```

```bash
# Create user if not exists (without shell login)
if ! id "$ftpuser" &>/dev/null; then
  sudo useradd -m -s /sbin/nologin "$ftpuser"
  echo "User $ftpuser created."
else
  echo "User $ftpuser already exists."
fi
```

```bash
# Set password for the user
sudo passwd "$ftpuser"
```

```bash
# Create FTP folder structure inside home for uploads/downloads
sudo mkdir -p /home/"$ftpuser"/ftp/files
```

```bash
echo "FTP setup complete. You can now connect with user '$ftpuser' using FTP on port 21."
echo "The FTP root is /home/$ftpuser/ftp (readonly), and writable directory is /home/$ftpuser/ftp/files."
```

```bash
sudo mkdir /web/site_1 -p
```

```bash
ls -lZd /var/www/html
```

```bash
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --reload
```

```bash
###
<VirtualHost *:80>
DocumentRoot /web/site_1
ServerName server.example.com
ErrorLog logs/server-error_log
TransferLog logs/server-access_log
</VirtualHost>
```

```bash
<Directory /web/site_1>
Require all granted
</Directory>
###
```

```bash
###
DocumentRoot "/web"
```

```bash
#
# Relax access to content within /var/www.
```

```bash
<Directory "/web">
AllowOverride None
# Allow open access:
Require all granted
</Directory>
```

```bash
# Further relax access to the default document root:
<Directory "/web">
###
```

```bash
## SHUT DOWN IN 10 MINUTES WITH NOTIFICATIONS
$ shutdown -h +10
$ shutdown -h 22:15
```

```bash
Table of crontab values
minute         0-59
hour           0-23
day of month   1-31
month          1-12
day of week    0-7
```

```bash
pwd
/home/sam
```

```bash
#### LOW LEVEL FORAMT
```

```bash
# hdparm secure erase (will fully wipe and reset drive)
sudo hdparm --user-master u --security-set-pass NULL /dev/sdX
sudo hdparm --user-master u --security-erase NULL /dev/sdX
```

```bash
sam@localhost:~$ wodim --devices 
wodim: Overview of accessible drives (2 found) :
```

```bash
0  dev='/dev/sr0'  rwrw-- : 'PLDS' 'DVD+-RW DH-16AES'
 1  dev='/dev/sr1'  rwrw-- : 'PIONEER' 'BD-RW   BDR-209M'
```

```bash
Open System Settings → Keyboard → Keyboard Shortcuts
Scroll to Custom Shortcuts (or click “+” to create new)
```

```bash
Command (m for help): n #####
Partition type:
p primary (0 primary, 0 extended, 4 free)
e extended
Select (default p): p ####
Partition number (1-4, default 1): 1 ####
First sector (2048-10485759, default 2048): ####
Using default value 2048
Last sector, +sectors or +size{K,M,G} (2048-10485759, default 10485759): +1G ####
Partition 1 of type Linux and of size 1 GiB is set
```

```bash
Command (m for help): w ####
The partition table has been altered!
```

```bash
sudo lvs
LV VG Attr LSize Pool Origin Data% Meta% Move Log Cpy%Sync Convert
root centos -wi-ao---- <8.00g
swap centos -wi-ao---- 1.00g
mylv_1 myvg_1 -wi-a----- 256.00m
```

```bash
ll /dev/mapper/myvg_1-mylv_1
lrwxrwxrwx. 1 root root 7 Jan 28 21:06 /dev/mapper/myvg_1-mylv_1 -> ../dm-2
```

```bash
ll /dev/myvg_1/mylv_1
lrwxrwxrwx. 1 root root 7 Jan 28 21:06 /dev/myvg_1/mylv_1 -> ../dm-2
```

```bash
sssd krb5-workstation authconfig-gtk 🡪 logout 🡪 ssh root server –X
LDAP BASE DN : dc=example,dc=com || LDAP Server : classroom.example.com
```

```bash
service🡪 chown nfsnobody /my_nfs 🡪 vim /etc/exports [my_nfs x.x.x.x/24](rw sync)
Client mkdir /mnt/nfs_docs 🡪fstab server7:/ mnt/nfs_docs nfs defaults 🡪 mount
```

```bash
# CREATE XFS PARTITIONS
$ fdisk -l
$ fdisk /dev/sdb
 $ n #new partition
 $ p #primary partition
 $ 1 #partition number default
 $ x2 enter keys # first and last sector default
 $ w #write the changes
```

```bash
# PERMISSIONS
$ ls -ald /nfs_shared
$ chown nfsnobody /nfs_shared
```

```bash
# ADDING NFS_SHARE PATH ENTRIES TO /ETC/EXPORTS
/nfs_shared *(rw,sync,no_root_squash)
/private *(rw,sync,no_root_squash)
```

```bash
# LIST MOUNTS BY CURRENT HOST
$ showmount -e <hostname>
```

```bash
help contents;
Client mariadb-client 🡪 service+firewall
show databases;
```

```bash
# CREATING A NEW SAMBA CONFIG
$ vim /etc/samba/smb.conf
```

```bash
[global]
workgroup = WORKGROUP
server string = Samba Server %v
netbios name = rocky-8
security = user
map to guest = bad user
dns proxy = no
ntlm auth = true
```

```bash
[Public]
path =  /shares/smb/data1
browsable =yes
writable = yes
guest ok = yes
read only = no
```

```bash
# Open Firewall Port
$ firewall-cmd --add-service=samba
$ firewall-cmd --add-service=samba --permanent
```

```bash
# VERIFY FIREWALL
$ firewall-cmd --list-services
```

```bash
[Private]
path = /srv/tecmint/private
valid users = @smb_group
guest ok = no
writable = no
browsable = yes
```

```bash
#### WEBMIN | https://localhost:10000
```

```bash
# FIREWALL 
sudo firewall-cmd --add-port=10000/tcp
"sudo firewall-cmd --runtime-to-permanent
"
```

```bash
# FOR LOCACALLY  OR EXTERNALLY 
sudo vim /etc/webmin/miniserv.conf      |||||| allow=127.0.0.1 OR YOUR ACCESS IP
```

```bash
# CHECK LOG
sudo cat /var/webmin/miniserv.error
```

```bash
# CREATE USER
sudo echo weminuser:yourpassword >> /etc/webmin/miniserv.users
echo "weminuser: bla bla  >> /etc/webmin/webmin.acl
sudo webmin passwd weminuser
```

```bash
#RESTART WEBMIN
sudo /etc/webmin/restart OR  sudo systemctl restart webmin
```

```bash
#### X11 ###  enable X11 forwarding rom Amazon EC2 emma white  ## https://shorturl.at/VgaIj
```

```bash
#### CHECK X11 STATUS
sudo cat /etc/ssh/sshd_config |grep -i X11Forwarding
```

```bash
# enable X11 Forwardin
$ sudo vi /etc/ssh/sshd_config
“X11Forwarding” parameter to “yes”
```

```bash
# Verify X11Forwarding parameter:
$ sudo cat /etc/ssh/sshd_config |grep -i X11Forwarding
```

```bash
# VIEW ONLINE
rtsp://wuke:hw3a3w@192.168.1.10
```

```bash
# CAPTURE STREAM
ffmpeg -i rtsp://wuke:hw3a3w@192.168.1.10 -r 15 C:\cmder\703.mp4
ffmpeg -i rtsp://wuke:hw3a3w@192.168.1.10 -r 15 -c:v libx265 C:\cmder\4k.mp4
```

```bash
sudo apt install mysql-server
sudo add-apt-repository ppa:iconnor/zoneminder-master
sudo apt install zoneminder
sudo a2enconf zoneminder
sudo a2enmod rewrite expires headers
sudo systemctl reload apache2
sudo systemctl enable zoneminder
sudo systemctl start zoneminder
```

```bash
## CHECK LAST REBOOT TIME
last -x -F | grep -E "shutdown|reboot" | sort -k5,5M -k6,6n
```

```bash
# TERMIUS SD CARD PATH
mnt/media_rw/4A21-0000
```

```bash
#### FFMPEG
sudo dnf -y install https://download.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
sudo dnf config-manager --set-enabled powertools
```

```bash
sudo dnf install -y https://download1.rpmfusion.org/free/el/rpmfusion-free-release-8.noarch.rpm
sudo dnf install -y https://download1.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-8.noarch.rpm
```

### Date & Time
_Snippets related to **Date & Time**._

```bash
sudo timedatectl set-time 14:30:00
sudo timedatectl set-time 2024-09-25
sudo timedatectl set-time '2024-09-25 14:30:00'
```

```bash
sudo timedatectl set-ntp false
```

```bash
crontab -l
timedatectl
```

### Package Management
_Snippets related to **Package Management**._

```bash
# MIDNIGHT COMMANDER	
sudo dnf install mc
```

```bash
# BIND DNS SERVER
sudo yum install bind bind-utils -y
```

```bash
sudo dnf install openssh-server openssh-clients
sudo systemctl enable sshd
sudo systemctl start sshd
```

```bash
# INSTALL VSFTPD AND FTP CLIENT
sudo dnf install vsftpd ftp -y
```

```bash
sudo yum install httpd httpd-manual -y
```

```bash
# INSTALL NFS
$ yum install nfs-utils libnfsidmap -y
```

```bash
# SAMBA UTILS
$ dnf install samba samba-common samba-client
```

```bash
# access the samba share from a Linux machine
$ dnf install samba-client
$ smbclient ‘192.168.58.102\private’ -U smbuser
```

```bash
# DEPENDENCIES
sudo yum -y install perl perl-Net-SSLeay openssl perl-IO-Tty perl-Encode-Detect
```

```bash
# GET LATEST RPM
http://download.webmin.com/download/yum/?C=M;O=D
sudo dnf install -y http://download.webmin.com/download/yum/webmin-2.013-1.noarch.rpm
```

```bash
## X11 Install required packages
$ sudo yum install xorg-x11-xauth -y
$ sudo yum install xclock xterm -y
```

```bash
sudo dnf install openscap-scanner scap-security-guide -y
```

```bash
## LYNIS SECURITY AUDIT
sudo dnf install lynis -y
sudo lynis audit system
```

```bash
#### FOOBAR WINE ####
sudo dnf install epel-release
sudo yum install snapd
sudo systemctl enable --now snapd.socket
sudo snap install foobar2000
```

```bash
# dnf clean all
# dnf check
# dnf check-update
# dnf update
```

```bash
#### XFCE DESKTOP ####
dnf --enablerepo=epel group -y install "Xfce" "base-x"
```

```bash
sudo dnf -y install ffmpeg  ffmpeg-devel
```

### Boot & Recovery (GRUB)
_Snippets related to **Boot & Recovery (GRUB)**._

```bash
#### GRUB ####
```

```bash
linux 16 line and end of UTF-8 type > rd.break > Press Ctrl+X
```

```bash
## RESCUING A NONBOOTING SYSTEM FROM THE  [grub> Prompt]
grub> ls
grub> ls (hd0,2)/boot
grub> set root=(hd0,2)
grub> linux /boot/vmlinuz-5.3.18-lp152.57-default root=/dev/sda2
grub> initrd /boot/initrd-5.3.18-lp152.57-default
grub> boot
```

```bash
## RESCUING A NONBOOTING SYSTEM FROM THE [grub rescue> Prompt]
grub rescue> ls (hd0,2)/boot
grub rescue> set prefix=(hd0,2)/boot/grub
grub rescue> set root=(hd0,2)
grub rescue> insmod normal
grub rescue> insmod linux
```

```bash
rub> linux /boot/vmlinuz-5.3.18-lp152.57-default root=/dev/sda2
grub> initrd /boot/initrd-5.3.18-lp152.57-default
grub> boot
```

```bash
## REINSTALLING YOUR GRUB CONFIGURATION {permanent repair}
$ sudo grub-mkconfig -o /boot/grub/grub.cfg
$ sudo grub-install /dev/sda
```

### Text Processing
_Snippets related to **Text Processing**._

```bash
# TOP
Sort by CPU usage / top -o %CPU
Sort by Memory usage: / top -o %MEM
Display specific users' processes: / top -u username
ps aux --sort=-%cpu | head -n 10
```

```bash
List top 5 memory-consuming processes
 ps aux --sort=-%mem | head -n 6
```

```bash
Sort by both CPU and memory usage
ps aux --sort=-%cpu,-%mem
```

```bash
Kill all processes with a specific name
ps aux | grep myprocess | awk '{print $2}' | xargs kill -9
```

```bash
Find all processes grouped by a user and sort by CPU
ps aux | awk '$1 == "user1" {print $0}' | sort -k3 -nr
```

```bash
fdisk -l
lsblk -f
watch -sh /source
tree --du -h | grep G]
```

```bash
# LVL 1 & L5 TREE DUMP
{ tree -h -L 1; echo ""; tree -h -L 5 | tail -n +2; } > "/f/Cloud/mega_mixes_g.txt"
```

```bash
## OS DETAILS 
cat /etc/relcat /etc/os-release
```

```bash
## REMOVE SPECIFIC FILE FROM MULTIPLE DIRECTRIES
find . -name \*.flac -type f -delete
```

```bash
### SYSTEM PERFORMANCE ANALYSIS ###
#
# SHOW TOP 10 PROCESSES USING THE MOST CPU
ps aux --sort=-%cpu | head
```

```bash
# CHECK RUNNING APACHE2 PROCESSES
ps aux | grep apache2
```

```bash
# SEND A HEAD REQUEST TO TEST HTTP RESPONSE HEADERS
curl -I http://your-server/
```

```bash
[connection]
autoconnect=true
```

```bash
## CONVERT WIFI PASSWORD TO HASH ## WPA3
wpa_passphrase <SSID> <password> | grep "sae_password=" | sed 's/\tsae_password=//'
```

```bash
# OR MANUALLY TRANSFER THE PUBLIC KEY (from your local machine)
$ scp ~/.ssh/my_id_rsa.pub username@server_ip:/home/username/.ssh/authorized_keys
```

```bash
# EXTRACT 7z.001 FILE
sudo 7z x 'test.7z.001'
```

```bash
cat filelist.txt | xargs -I % cp /path/to/source/folder/% /path/to/destination/folder/
for /f "delims=" %i in (filelist.txt) do copy "C:\path\to\source\folder\%i" "C:\path\to\destination\folder\"
```

```bash
# Enable FTP transfer logging
xferlog_enable=YES
xferlog_std_format=YES
```

```bash
# Add user to vsftpd userlist
if ! grep -q "^$ftpuser$" /etc/vsftpd/user_list 2>/dev/null; then
  echo "$ftpuser" | sudo tee -a /etc/vsftpd/user_list
fi
```

```bash
# --- Setup directory structure and permissions for chroot jail ---
```

```bash
Assign Keyboard Shortcuts
```

```bash
NAME: BD1
COMMAND: /home/sam/Documents/disc_drives/toggle-sr0.sh
SHORTCUT: shift + ctrl + 2
```

```bash
sudo pvs
PV VG Fmt Attr PSize PFree
/dev/vda2 centos lvm2 a-- <9.00g 0
/dev/vdb1 lvm2 --- 1.00g 1.00g
```

```bash
sudo oscap xccdf eval \
  --profile xccdf_org.ssgproject.content_profile_stig \
  --results /tmp/scan-results.xml \
  --report /tmp/scan-report.html \
  /usr/share/xml/scap/ssg/content/ssg-centos-stream9-xccdf.xml
```

### Editors
_Snippets related to **Editors**._

```bash
# TEST SPEED 
curl -o /dev/null http://speedtest.tele2.net/100MB.zip
```

```bash
# OPENED PORT LIST
$  sudo ss -tunlp
```

```bash
#DNS
cat /etc/resolv.conf
sudo vim /etc/hosts >> 10.0.0.198 slvr.site dns
```

```bash
sudo vim /etc/named.conf
```

```bash
#### VIM ####
```

```bash
# SEARCH FOR FILES NAMED 'RCLONE' STARTING FROM THE /USR/BIN DIRECTORY
find /usr/bin -name rclone 2>/dev/null
```

```bash
# SEARCH FOR FILES NAMED 'RCLONE' STARTING FROM THE /USR/BIN DIRECTORY
find /usr/bin -name rclone 2>/dev/null
```

```bash
Press "e" for edit  kernel
Use "Esc" for UEFI enabled systems. (interrupt boot process)
```

```bash
# CHECK THE GENERATED KEY FILES (on your local machine)
$ ls -l ~/.ssh/   # id_rsa (private key) and id_rsa.pub (public key)
```

```bash
# Set default file permissions for uploaded files
local_umask=022
```

```bash
sudo touch index.html
sudo vim index.html
```

```bash
sudo vim /etc/httpd/conf.d/v_hosting.conf
```

```bash
sudo vim /etc/httpd/conf/httpd.conf ## LINE 119
```

```bash
## CREATING SCHEDULED SHUTDOWNS WITH CRON
$ sudo nano /etc/crontab
m  h  dom mon dow user command
10 22 *   *    *  root /sbin/shutdown -h +20
```

```bash
Command (m for help): t ####
Selected partition 1
Hex code (type L to list all codes): 8e ####
Changed type of partition 'Linux' to 'Linux LVM'
```

```bash
vim /etc/fstab
```

```bash
# ADD SECURE DIRECTORY2
$ vi /etc/samba/smb.conf
```

## User & Permissions

### User Management
_Snippets related to **User Management**._

```bash
## USER ADD & ELEVATE
useradd sam -c "sam fisher"
passwd sam
```

```bash
usermod -aG wheel sam
su - sam
sudo vim /etc/passwd > make [root:x:0:0:root:/root:/sbin/nologin]
id sam
uid=1001(sam) gid=1001(sam) groups=1001(sam),10(wheel)
```

```bash
sudo chage -l sam
sudo chage -E +1month sam
sudo chage -l sam
```

```bash
sudo usermod -s /sbin/nologin student
cat /etc/passwd | grep student
student:x:1000:1000:student:/home/student:/sbin/nologin
```

```bash
## TO ACTIVATE AN ACCOUNT
$ sudo usermod --expiredate -1 stash
```

```bash
sudo usermod -aG HR sam
```

```bash
# SAMBA USER CREATE
$ useradd smbuser
$ smbpasswd -a smbuser
```

```bash
# SAMBA GROUP CREATE
$ groupadd smb_group
$ usermod -g smb_group smbuser
```

### Groups
_Snippets related to **Groups**._

```bash
sudo groupadd HR
sudo chgrp HR /Finance/
```

### File Permissions & Ownership
_Snippets related to **File Permissions & Ownership**._

```bash
sudo chown root:root /home/sam
sudo chmod 755 /home/sam
```

```bash
# Change ownership of home directory to root and permission to 755 (not writable by user)
sudo chown root:root /home/"$ftpuser"
sudo chmod 755 /home/"$ftpuser"
```

```bash
# Change ownership of ftp directory to nobody:nobody, not writable by user
sudo chown nobody:nobody /home/"$ftpuser"/ftp
sudo chmod 755 /home/"$ftpuser"/ftp
```

```bash
# Change ownership of files directory to ftpuser (writable)
sudo chown "$ftpuser":"$ftpuser" /home/"$ftpuser"/ftp/files
sudo chmod 755 /home/"$ftpuser"/ftp/files
```

```bash
chmod +x toggle-sr0.sh
```

```bash
# SAMABA PERMISSIONS
$ chmod -R 755 /shares/smb/data1
$ chown -R  nobody:nobody /shares/smb/data1
$ chcon -t samba_share_t /shares/smb/data1
```

```bash
# secure samba share directory for accessing files securely by samba users
$ mkdir -p /shares/smb/data2
$ chmod -R 770 /shares/smb/data2
$ chcon -t samba_share_t /shares/smb/data2
$ chown -R root:smb_group /shares/smb/data2
```

### sudo
_Snippets related to **sudo**._

```bash
##
# passwordless sudo:
sudo visudo
```

```bash
sudo hostnamectl set-hostname openstack1
```

```bash
## ISO TO USB BOOT DISC
sudo dd status=progress if=ubuntu-20.04.1-LTS-desktop-amd64.iso of=/dev/sdb
```

```bash
sudo systemctl set-default graphical.target	GUI
sudo systemctl set-default multi-user.target	CLI
```

```bash
sudo init 6
```

```bash
sudo mkdir /Finance
```

```bash
sudo systemctl restart vsftpd
sudo systemctl status vsftpd
```

```bash
# --- Restart vsftpd to apply changes ---
sudo systemctl restart vsftpd
```

```bash
sudo systemctl enable httpd.service
sudo systemctl start httpd.service
```

```bash
sudo systemctl reload httpd.service
curl server.example.com
```

```bash
# blkdiscard (non-secure, quick discard)
sudo blkdiscard -f /dev/sdX
```

```bash
sudo fdisk /dev/vdb
```

```bash
sudo fdisk /dev/vdb
```

```bash
sudo pvcreate /dev/vdb1
Physical volume "/dev/vdb1" successfully created.
```

```bash
sudo vgcreate myvg1 /dev/vdb1
Volume group "myvg_1" successfully created
```

```bash
sudo lvcreate -n mylv_1 -L 256M myvg1
Logical volume "mylv_1" created.
```

```bash
$ sudo parted
$ (parted) select /dev/sdb
# (parted) print
(parted) print all
```

### SELinux
_Snippets related to **SELinux**._

```bash
man semanage fcontext
sudo semanage fcontext -a -t httpd_sys_content_t "/web(/.*)?"
sudo restorecon -R -v /web
```

## Process & Resource Management

### Processes & Jobs
_Snippets related to **Processes & Jobs**._

```bash
# Monitor Commands
psaux
```

```bash
htop
pkill -KILL -U samf
```

```bash
# CHECK CACHE FILE USAGE IN LINUX:
free -h
vmstat -s
cat /proc/meminfo
top or htop
slabtop
```

```bash
network={
    ssid="MyWiFiNetwork"
    psk=04b8fgrdfgd3fe269045fvvvcvdgfdcvc1d6c583aa1bedb22d2cfa0f17
}
```

```bash
# UNRAR FILE	
unrar e 'REV.part01.rar' rev-fgr
```

```bash
ls
Desktop HRDATA hrdata_bkp.tar usage_script.sh
```

```bash
Check if the process is still running
ps aux | grep blkdiscard
sudo iotop -o
```

```bash
# CHCEK DOCKER PACK.YML FOR DOCKER COMPSOE
```

### Performance & System Info
_Snippets related to **Performance & System Info**._

```bash
# CPU INFORMATION 
lscpu
```

```bash
# RAM INFORMATION 
free -h
```

### Services (systemd)
_Snippets related to **Services (systemd)**._

```bash
ls -l /etc/systemd/system/default.target
```

```bash
# DISPLAY STATUS OF APACHE2 SERVICE
systemctl status apache2
```

```bash
# ENABLE NFS ON START
$ systemctl enable rpcbind
$ systemctl enable nfs-server
$ systemctl start rpcbind
$ systemctl start rpc-statd
$ systemctl start nfs-idmapd
```

```bash
## SECURING NFS
systemctl enable nfs-secure-server.service 
ystemctl start nfs-secure-server.service
```

```bash
# ENABLE AND START SERVICES
$ systemctl start smb
$ systemctl enable smb
$ systemctl start nmb
$ systemctl enable nmb
```

```bash
# STATUS
$ systemctl status smb
$ systemctl status nmb
```

```bash
# RESTART SAMBA SERVICE
$ systemctl restart smb
$ systemctl restart nmb
```

## Networking

### Interfaces & Autoconnect
_Snippets related to **Interfaces & Autoconnect**._

```bash
nmtui
```

### IP & Routing
_Snippets related to **IP & Routing**._

```bash
# GATEWAY
ip route show default
```

```bash
# PING A REMOTE SERVER TO TEST CONNECTIVITY
ping <server-ip>
```

```bash
# TRACE ROUTE TO A REMOTE SERVER TO IDENTIFY NETWORK PATH AND DELAYS
traceroute <server-ip>
```

### SSH & Keys
_Snippets related to **SSH & Keys**._

```bash
### SSH KEYGEN
```

```bash
# GENERATE THE SSH KEY PAIR (on your local machine)
$ ssh-keygen -t rsa -b 4096 -C "bob@gmail.com" # OR any comment
```

```bash
# COPY THE PUBLIC KEY TO THE SERVER (from your local machine)
$ ssh-copy-id username@server_ip
```

```bash
# LOG INTO THE SERVER
$ ssh username@server_ip
```

```bash
# ON THE SERVER: CREATE THE .ssh DIRECTORY AND AUTHORIZED_KEYS FILE (if not already done by ssh-copy-id)
$ mkdir -p ~/.ssh
$ chmod 700 ~/.ssh
$ cd .ssh/
$ cat my_id_rsa.pub >> ~/.ssh/authorized_keys
$ chmod 600 ~/.ssh/authorized_keys
```

```bash
# RESTART THE SSH SERVICE (on the server)
$ sudo systemctl restart sshd
```

```bash
authconfig-gtk ssh ldapuser7@localhost
```

```bash
# restart ssh service 
$ sudo service sshd restart
```

### HTTP & Curl
_Snippets related to **HTTP & Curl**._

```bash
## SEND REQUEST TO RELOAD
$ curl -X POST localhost:7001/-/reload
```

### Firewall
_Snippets related to **Firewall**._

```bash
# --- Step 8: Open FTP port in firewall (if firewalld active) ---
sudo firewall-cmd --permanent --add-port=21/tcp
sudo firewall-cmd --reload
```

```bash
# firewall-cmd --permanent --add-service=nfs
# firewall-cmd --reload
# sudo systemctl stop firewalld.service
```

## Storage & Filesystem

### Disk & Partitions
_Snippets related to **Disk & Partitions**._

```bash
lsblk
 mkfs.xfs /dev/myvg_1/mylv_1
```

```bash
blkid
```

```bash
#### GNU PARTED - fdisk  sfdisk
```

### LVM
_Snippets related to **LVM**._

```bash
vgs
lvextend -r -L +100M /dev/myvg_1/mylv_1
df -h
```

```bash
LVM
pvcreate /dev/vdb1
vgcreate myvg1 /dev/vdb1
lvcreate -n mylv1 –L 265M myvg1
mkfs.ext4 /dev/vdb1/myvg1-mylv1
fstab
```

```bash
vgextend –L +600M /dev/vdb1/myvg1
lvextend –L +200M /dev/vdb1/myvg1-mylv1
```

### Filesystems & Mounts
_Snippets related to **Filesystems & Mounts**._

```bash
## MOUNT ISO
$ mkdir viewpoint
$ sudo mount -o loop myfile.iso viewpoint
$ sudo umount viewpoint
```

```bash
$ sudo umount /dev/sdc
$ sudo parted /dev/sdc
(parted) mklabel gpt
(parted) p
(parted) mkpart "images" ext4 1MB 2004MB
(parted) mkpart "audio files" xfs 2005MB 100%
(parted) print
Number Start End Size File system Name Flags
1 1049kB 2005MB 2004MB ext4 images
2 2006MB 4009MB 2003MB xfs audio files
```

```bash
🡪 LVM 🡪 targetcli pack 🡪 service 🡪 firewall port 3260/tcp 🡪 targetcli configs 🡪 initiator
Client fstab /mount xfs _netdev 🡪 iscsiadm 🡪 logout
```

```bash
# MAKE THE FILE SYSTEM
$ mkfs.xfs /dev/sdbl
```

```bash
# MOUNT 
$ mount /dev/sdbl /nfs_shared
$ mount /dev/sdcl /private
```

```bash
# ADD NFS MOUNTS TO /ETC/FSTAB FOR AUTO-MOUNT
$ /dev/sdbl /nfs_shared xfs defaults 0 0
$ /dev/sdcl /private xfs defaults 0 0
```

```bash
###CLIENT CONFIG ###
# CREATE MOUNT DIRECTORY
$ mkdir /mnt/server_nfs_link
```

```bash
# MOUNT SERVER SHARE
$ mount hostname:/nfs_share /mnt/server_nfs_link
$ df -h
```

```bash
# PERMENT ADDING vim /etc/fstab for auto-mount
$ <histname>:/nfs_share /mnt/nsf_link    nfs    defaults    0 0
```

### File & Folder Ops
_Snippets related to **File & Folder Ops**._

```bash
## FIND LARGER FILES
find . -type f -size +500M
find . -type f -size +500M -exec ls -lh {} \; | awk '{print $9, $5}'
```

```bash
## FOLDER SIZE  
du -sh
```

```bash
## MAKE ISO
$ genisoimage -o output_image.iso directory_name du -sh ~/up/ - directory size
```

```bash
## FILE COPY FORM SVR 2 SVR scp /home/student/testfile bob@desktop:/home/bob 
$ rsync –av /home/student/testfile bob@desktop:/home/bob
```

```bash
# COPY FILES FORM WINDOWS TO LINUX 
scp .\p7zip.zip sam@1.22.3.6:/home/sam/
```

```bash
# COPY FILES FORM LINUX MACHINE TO WINDOWS
scp sam@192.168.58.119:/var/www/remotely C:\Users\uchithr\Downloads\D_DRIVE
```

```bash
## MOUNT DISC	
sudo blkid	
sudo mkdir /media/dvd-r	
sudo mount /dev/sr0 /media/dvd-r	
tree --du -h | grep G]
```

```bash
#### FIND ####
```

```bash
# FOLDER FIND	
find ~ -type d -name "Documents"
```

```bash
# FIND  FILE TYPE	
find . -type f -name "*.txt"
```

```bash
# FIND AND COPY	
find -name  myfile.mp3 -exec cp  {}  /home/sam  \;
```

```bash
## FIND AND COPY BELOW 200M FILES	
find -type f -size -200M -exec cp {} /mnt/sdf2/1/X_pks \;
find /etc/ -name "passwd"
```

```bash
## FIND
find / -name rclone 2>/dev/null
```

```bash
## LIST ISO FILES IN ALL SUBDIRECTORIES
find /path/to/directory -type f -name "*.iso"
```

```bash
## FOR BETTER READABILITY WITH FILE SIZES
find /path/to/directory -type f -name "*.iso" -exec ls -lh {} +
```

```bash
cp usage_script.sh /home/sam/HRDATA/
```

```bash
crontab -e
crontab -l
00 09 * * * cp /home/sam/usage_script.sh /home/sam/HRDATA/
```

```bash
mkdir mkdir /lv_data
```

```bash
# CREATE NFS SHAREPOINTS
$ mkdir /nfs_shared
$ mkdir /private
```

```bash
samba samba-client 🡪 service+firewall 🡪 mkdir /smb_sahre context type 🡪configs
Client cifs-utils samba-client [income ]fstab cifs credentials=mysec
```

```bash
# SAMBA SHARE FOLDER
$ mkdir -p /shares/smb/data1
```

```bash
# BACKUP SAMBA CONF
$ mv /etc/samba/smb.conf /etc/samba/smb.conf.bak
```

```bash
ARM 32 Bit  older devices armeabi-v7a
ARM 64 Bit  most devices  arm64-v8a
```

```bash
# CHECK THE ARM VERSION OF YOUR ANDROID PHONE @ IN A TERMINAL
uname -m   #mine ARMv8-A
```

### Compression & Archiving
_Snippets related to **Compression & Archiving**._

```bash
## 7-ZIP
sudo dnf install epel-release
sudo dnf install p7zip p7zip-plugins
```

```bash
# ZIP SINGLE FILE	
zip -r -s 500m myzip myfile.mkv
```

```bash
# UZIP FILE	unzip file.zip
cat cloud_dump.zip.* > cloud_dump.zip
unzip cloud_dump.zip
```

```bash
## MAKE TAR FILE	
tar cvf /home/sam/hrdata_bkp.tar /HRDATA
```

```bash
## UNTAR  FILE	
tar xvf hrdata_bkp.tar
```

```bash
## LIST OR VIEW FILE INFORMATION WITHOUT EXTRACT
unzip -l zip_file1.zip
unrar l rar_file1.rar
```

```bash
## TEST FILE INTEGRITY
$ unzip -t your_file.zip
$ unrar t your_file.rar
```

```bash
<>p4txz!p
```

```bash
tar xz name.tar.gz.
```

```bash
# ENCRYPT
tar -czf - test | split --bytes=15MB | openssl enc -e -aes256 -out tarball.tar.gz.
```

```bash
# DECRYPT
openssl enc -d -aes256 -in tarball.tar.gz.* | tar xz -C /root/Desktop/out/
```

```bash
# TO tar + gpg + split
$ tar -cJvpf - test | gpg --symmetric --cipher-algo aes256 | split -d -b 10MB - name.tar.xz.gpg.
```

```bash
# TO DECRYPT:
$ cat outputfile.tar.xz.gpg.* | gpg -d | tar -xJvpf -
```

```bash
The best way to compress a folder in Linux server with splitting and password protection would be to use the tar command along with the gzip compression algorithm. Here's an example command that you can use:
```

```bash
$ tar -czvf - /path/to/folder | split -b 100M -d -a 4 - file.tar.gz.part_ && openssl enc -aes-256-cbc -salt -in file.tar.gz.part_* -out archive.tar.gz.enc
```

```bash
-c: create a new archive |*| -z: use gzip compression |*| -v: verbose while creating |*| -f: specifies the filename of the archive.
split: split a large file into smaller ones.
-b: size of each split file.
-d: split to use numeric suffixes for the split files.
-a: length of the suffixes (4)
```

### NFS
_Snippets related to **NFS**._

```bash
#### NFS
```

```bash
####SERVER CONFIG ###
100G & 5G nfs_share
```

```bash
# EXPORT THE NFS NFS_SHARE
$ exportfs -rv
```

## File Transfer & Remote Access

### SCP & Rsync
_Snippets related to **SCP & Rsync**._

```bash
# Use PAM for authentication
pam_service_name=vsftpd
```

## Databases

### MariaDB / MySQL
_Snippets related to **MariaDB / MySQL**._

```bash
# DATABASE (MYSQL) MONITORING
# SHOW ACTIVE MYSQL PROCESSES (REQUIRES ROOT OR MYSQL ADMIN USER)
mysqladmin processlist -u root -p
```

```bash
mariadb mariadb-client 🡪 service+firewall 🡪 mysql_secure_installation
mysql -u root –p
```

## Automation & Scheduling

### Cron
_Snippets related to **Cron**._

```bash
#### CRONTAB
```

## Services & Applications

### Apache / Nginx
_Snippets related to **Apache / Nginx**._

```bash
httpd -t > Syntax OK
```

### Samba
_Snippets related to **Samba**._

```bash
# Verify the configurations
$ testparm
```

### VSFTPD (FTP)
_Snippets related to **VSFTPD (FTP)**._

```bash
# BACKUP ORIGINAL CONFIG
sudo cp /etc/vsftpd/vsftpd.conf /etc/vsftpd/vsftpd.conf.bak
```

```bash
### CONFIGURE VSFTPD ####
vim /etc/vsftpd/vsftpd.conf
```

```bash
# Jail local users to their home directory for security
chroot_local_user=YES
```

```bash
# Enable userlist: only allow users in user_list file
userlist_enable=YES
userlist_deny=NO
userlist_file=/etc/vsftpd/user_list
```

```bash
# ADD CURRENT USER TO THE ALLOWED LIST
echo sam | sudo tee -a /etc/vsftpd/user_list
```

### Sublime Text
_Snippets related to **Sublime Text**._

```bash
## SUBLIME TEXT 4
$ sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg
$ sudo dnf config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo
$ sudo dnf install sublime-text -y
```

### CCTV
_Snippets related to **CCTV**._

```bash
#### CCTV ## ISPYAGENTDVR ##  Shinobi vs Zoneminder vs Frigate vs Motioneye vs Bluecherry vs iSpy
```

## Uncategorized

### Misc
_Snippets related to **Misc**._

```bash
# LOG FILES LOCATION
/root/var
```

```bash
# VERIFY SHELL MODE
$ echo $SHELL
```

```bash
# CHECK SSD OR HDD ON DISK # 1 for hdd & 0 for ssd
cat /sys/block/sda/queue/rotational
```

```bash
# FILE INFORAMTION
file rclone
stat rclone
```

```bash
## CREATE MULTIPLE FILES  
touch myfile{1..5}
```

```bash
## CHK ######################################################
```

```bash
# -------------------------------------------------------------------------
```

```bash
## DNS ###########################################################################################################
```

```bash
#### DATE/TIME ####
```

```bash
# DELETE ENTIRE LINE (must be in non-insert mode)
$ dd
```

```bash
exit
exit
```

```bash
#### USER CONFIGURATION ####
```

```bash
## FILE AUTH TO OTHERS
touch myfile
```

```bash
#### FILE PERMISSIONS ####
```

```bash
#### FILE COMPRESSION
```

```bash
# RAR FILE
```

```bash
####___________
```

```bash
#_#_____
```

```bash
# Disable anonymous login
anonymous_enable=NO
```

```bash
# Enable IPv6 listening
listen_ipv6=YES
```

```bash
# Disable IPv4 listening (optional)
listen=NO
```

```bash
# --- Add user to system and userlist ---
read -p "Enter username to create for FTP access: " ftpuser
```

```bash
#### APACHE
```

```bash
(Redirect 301 / http://slvr.lk)
```

```bash
date
Thu Jan 28 08:47:39 EST 2021
```

```bash
#### DRIVE EJECT
```

```bash
cd /home/sam/Documents/disc_drives/
```

```bash
gedit toggle-sr0.sh
```

```bash
#!/bin/bash
eject -T /dev/sr0
```

```bash
---
cat toggle-sr1.sh 
#!/bin/bash
eject -T /dev/sr1
```

```bash
/home/sam/Documents/disc_drives/toggle-sr0.sh
```

```bash
#### LVM
```

```bash
Calling ioctl() to re-read partition table.
Syncing disks.
```

```bash
Command (m for help): p ####
```

```bash
Disk /dev/vdb: 5368 MB, 5368709120 bytes, 10485760 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk label type: dos
Disk identifier: 0xe5ae08db
```

```bash
Device Boot Start End Blocks Id System
/dev/vdb1 2048 2099199 1048576 8e Linux LVM
```

```bash
Command (m for help): ^C
```

```bash
/dev/myvg_1/mylv_1 /lv_data xfs defaults 0 0
or
UUID="6fa210d8-f319-466a-863a-12356f133090" /lv_data xfs defaults 0 0
```

```bash
#### LDAP
```

```bash
Realm : Example.com | KDC : classroom.example.com 🡪 Admin Servers : same
```

```bash
#### iSCSI
```

```bash
#### MARIA DB
```

```bash
#### SAMBA
```

```bash
# TEST SHARE
$ cd /shares/smb/data1 | touch file{1..3}.txt
```

```bash
# SECURE SAMBA SHARE
```

```bash
http://localhost:8090/index.html?v=0.895409558265448#Live
```

```bash
## DIAGNOSTIC
```

```bash
#### ANDROID
```
