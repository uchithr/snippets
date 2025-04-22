#!/bin/bash

# This script helps clean up disk space on the root filesystem safely.

echo "Starting system cleanup..."

# 1. Clean package manager cache (for RHEL/CentOS/AlmaLinux)
echo "Cleaning DNF/YUM cache..."
dnf clean all -y
rm -rf /var/cache/dnf

# 2. Remove orphaned packages
echo "Removing orphaned packages..."
dnf autoremove -y

# 3. Vacuum journal logs older than 3 days or larger than 200MB
echo "Cleaning journal logs..."
journalctl --vacuum-time=3d
journalctl --vacuum-size=200M

# 4. Delete rotated and archived logs
echo "Deleting old rotated logs..."
find /var/log -type f -name "*.gz" -delete
find /var/log -type f -name "*.1" -delete
find /var/log -type f -name "*.old" -delete

# 5. Clear system cache
echo "Clearing system cache..."
rm -rf /var/cache/*

# 6. Remove temporary files
echo "Removing temp files from /tmp and /var/tmp..."
rm -rf /tmp/*
rm -rf /var/tmp/*

# 7. Clear user trash and cache
echo "Cleaning user cache and trash (if run as root)..."
rm -rf /home/*/.cache/*
rm -rf /home/*/.local/share/Trash/*

echo "System cleanup completed successfully!"