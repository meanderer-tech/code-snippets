#!/bin/bash

## This script pulls regular users in the system and prints it along with password hash.
## there may be faster implementations but less safe if different entries are scrambled within /etc/passwd file

#loop through user list in Ubuntu distro and output username:password hash:fullname
#this can then be imported to another server with a different script
USERS=($(awk 'BEGIN{FS=":"} {if ($3 > 1000 && $1 !="nobody") print $1}' /etc/passwd))
for USER in ${USERS[@]} ; do
        FULLNAME=$(sudo awk 'BEGIN{FS=":"} {if ($1 == '${USER}') print $5}')
        CREDENTIALS=$(sudo grep ^$USER: /etc/shadow | awk 'BEGIN{FS=":"} {print $1":"$2"}')
	echo "$CREDENTIALS:$FULLNAME"
done


#google-authenticator 2FA works by placing .google_authenticator file in user's home directory,
#this file can be moved to a new host to copy the credentials over if needed.
#insert exported Google authenticator files to user directory
FILES=files
USERS=($(awk 'BEGIN{FS=":"} {if ($3 > 1000 && $1 !="nobody") print $1}' /etc/passwd))
for USER in ${USERS[@]} ; do
	sudo mv files/.google_authenticator-${USER} /home/${USER}/.google_authenticator
	sudo chown ${USER}:${USER} /home/${USER}/.google_authenticator
	sudo chmod 600 /home/${USER}/.google_authenticator
done
