#!/bin/bash

## This script pulls regular users in the system and prints it along with password hash.
## there may be faster implementations but less safe if different entries are scrambled within /etc/passwd file

USERS=($(awk 'BEGIN{FS=":"} {if ($3 > 1000 && $1 !="nobody") print $1}' /etc/passwd))
for USER in ${USERS[@]} ; do
        sudo grep $USER /etc/shadow | awk 'BEGIN{FS=":"} {print $1":"$2}'
done
