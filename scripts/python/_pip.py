#TAKE A BACKUP OF ALL INSTALLED PIP PACKAGES
pip freeze > requirements.txt



#RESTORE THE PACKAGES LATER
pip install -r requirements.txt






#If you have multiple Python versions
py -3.11 -m pip list
py -3.11 -m pip freeze
pip3 list

