#_# INSTALL smbclient #_#
# sudo apt-get update
# sudo apt-get install smbclient

#_# CREATE A BACKUP SCRIPT #_#
# $ sudo nano /usr/local/bin/backup_db.sh



!/bin/bash

# Variables
DB_FILE="/var/www/remotely/dbfile.db"
BACKUP_DIR="/var/www/remotely/backups"
TIMESTAMP=$(date +"%Y%m%d%H%M%S")
BACKUP_FILE="$BACKUP_DIR/dbfile_$TIMESTAMP.db"
WINDOWS_SHARE="//windows_server/share"
WINDOWS_USER="your_username"
WINDOWS_PASS="your_password"

### CREATE BACKUP DIRECTORY IF IT DOESN'T EXIST ###
mkdir -p $BACKUP_DIR

### COPY THE DATABASE FILE TO THE BACKUP DIRECTORY ###
cp $DB_FILE $BACKUP_FILE

### COPY THE BACKUP FILE TO THE WINDOWS SHARED FOLDER ###
smbclient $WINDOWS_SHARE -U $WINDOWS_USER%$WINDOWS_PASS -c "put $BACKUP_FILE $(basename $BACKUP_FILE)"

#### CLEAN UP OLD BACKUPS (OPTIONAL, KEEP LAST 5 BACKUPS) ###
cd $BACKUP_DIR
ls -1tr | head -n -5 | xargs -d '\n' rm -f --







#_# MAKE THE SCRIPT EXECUTABLE #_#
# $ sudo chmod +x /usr/local/bin/backup_db.sh


#_# SET UP CRON JOB #_# 
# sudo crontab -e
# 0 0 */4 * * /usr/local/bin/backup_db.sh


#_# MAKE SURE EVERYTHING IS SET UP CORRECTLY BY MANUALLY RUNNING THE SCRIPT ONCE #_#
# sudo /usr/local/bin/backup_db.sh