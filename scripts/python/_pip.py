#TAKE A BACKUP OF ALL INSTALLED PIP PACKAGES
pip freeze > requirements.txt



#RESTORE THE PACKAGES LATER
pip install -r requirements.txt
