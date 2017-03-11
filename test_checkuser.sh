#!/bin/bash
#
## Refer: https://bash.cyberciti.biz/guide/Shell_functions_library
# Load the  myfunctions.sh 
# My local path is /home/andrew/Working/Improbability/theatrix_functions.sh
. /home/andrew/Working/Improbability/theatrix_functions.sh

# Define local variables

if [ -z $1 ] ; then
        echo "Enter username: "
        read u
else
        u=$1
fi

checkuser $u
exit 1