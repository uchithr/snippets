# ----------------------------------------
# Enhanced vsftpd FTP Server Setup Script on AlmaLinux
# Supports multiple users, SSL/TLS, fail2ban and more
# ----------------------------------------

set -euo pipefail

# --- Helper Functions ---

timestamp() {
  date +"%Y%m%d_%H%M%S"
}

backup_vsftpd_conf() {
  local backup_file="/etc/vsftpd/vsftpd.conf.bak_$(timestamp)"
  echo "Backing up vsftpd.conf to $backup_file"
  sudo cp /etc/vsftpd/vsftpd.conf "$backup_file"
}

create_user() {
  local user=$1
  if ! id "$user" &>/dev/null; then
    sudo useradd -m -s /sbin/nologin "$user"
    echo "User '$user' created."
  else
    echo "User '$user' already exists."
  fi
  echo "Set password for user '$user':"
  sudo passwd "$user"
  # Add to vsftpd userlist if not present
  if ! grep -q "^$user$" /etc/vsftpd/user_list 2>/dev/null; then
    echo "$user" | sudo tee -a /etc/vsftpd/user_list
  fi

  # Directory setup
  sudo chown root:root /home/"$user"
  sudo chmod 755 /home/"$user"

  sudo mkdir -p /home/"$user"/ftp/files

  sudo chown nobody:nobody /home/"$user"/ftp
  sudo chmod 755 /home/"$user"/ftp

  sudo chown "$user":"$user" /home/"$user"/ftp/files
  sudo chmod 755 /home/"$user"/ftp/files
}

setup_vsftpd_conf() {
  sudo tee /etc/vsftpd/vsftpd.conf > /dev/null <<EOF
anonymous_enable=NO
local_enable=YES
write_enable=YES
local_umask=022
dirmessage_enable=YES
xferlog_enable=YES
xferlog_std_format=YES
listen_ipv6=YES
listen=NO
chroot_local_user=YES
pam_service_name=vsftpd
userlist_enable=YES
userlist_deny=NO
userlist_file=/etc/vsftpd/user_list
# SSL/TLS settings (enable if cert files exist)
rsa_cert_file=/etc/ssl/certs/vsftpd.pem
rsa_private_key_file=/etc/ssl/private/vsftpd.key
ssl_enable=YES
allow_anon_ssl=NO
force_local_data_ssl=YES
force_local_logins_ssl=YES
ssl_tlsv1=YES
ssl_sslv2=NO
ssl_sslv3=NO
require_ssl_reuse=NO
ssl_ciphers=HIGH
EOF
}

setup_firewall() {
  echo "Configuring firewall for FTP port 21 and FTPS port 990..."
  sudo firewall-cmd --permanent --add-port=21/tcp
  sudo firewall-cmd --permanent --add-port=990/tcp
  sudo firewall-cmd --reload
}

setup_fail2ban_vsftpd() {
  echo "Setting up fail2ban jail for vsftpd..."

  sudo tee /etc/fail2ban/jail.d/vsftpd.local > /dev/null <<EOF
[vsftpd]
enabled = true
port    = ftp,ftp-data,ftps,ftps-data
filter  = vsftpd
logpath = /var/log/secure
maxretry = 5
bantime = 3600
EOF

  sudo systemctl restart fail2ban
}

print_summary() {
  echo "--------------------------------------------------"
  echo "FTP Server Setup Complete!"
  echo "Users configured: $*"
  echo "FTP service is running: $(systemctl is-active vsftpd)"
  echo "Firewall ports open: 21 (FTP), 990 (FTPS)"
  echo "FTP root: /home/<user>/ftp (read-only)"
  echo "Writable directory: /home/<user>/ftp/files"
  echo "SSL/TLS enabled (if certificates present)."
  echo "Fail2ban monitoring FTP login attempts."
  echo "--------------------------------------------------"
}

# --- Main script ---

echo "Installing vsftpd, ftp, and fail2ban..."
sudo dnf install -y vsftpd ftp fail2ban

echo "Starting and enabling vsftpd service..."
sudo systemctl enable --now vsftpd

backup_vsftpd_conf
setup_vsftpd_conf

# Input users - either from file or prompt interactively
if [[ -f "ftpusers.txt" ]]; then
  echo "Found ftpusers.txt, creating users listed inside..."
  mapfile -t users < ftpusers.txt
else
  read -p "Enter usernames for FTP access (comma-separated): " input_users
  IFS=',' read -ra users <<< "$input_users"
fi

for u in "${users[@]}"; do
  user=$(echo "$u" | xargs)  # trim whitespace
  if [[ -n "$user" ]]; then
    create_user "$user"
  fi
done

echo "Restarting vsftpd..."
sudo systemctl restart vsftpd

setup_firewall
setup_fail2ban_vsftpd

print_summary "${users[@]}"