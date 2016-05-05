#!/bin/bash
#
## Refer: https://bash.cyberciti.biz/guide/Shell_functions_library
# Load the  myfunctions.sh 
# My local path is /home/andrew/Working/Improbability/theatrix_functions.sh
. /home/andrew/Working/Improbability/theatrix_functions.sh

# Define local variables
# var1 is not visitable or used by myfunctions.sh
var1="The Mahabharata is the longest and, arguably, one of the greatest epic poems in any language."

# Invoke the is_root()
is_root && echo "You are logged in as root." || echo "You are not logged in as root."

# Find out if user account vivek exits or not
is_user_exits "vivek" && echo "Account found." || echo "Account not found."

# Display $var1
echo -e "*** Orignal quote: \n${var1}"

# Invoke the to_lower()
# Pass $var1 as arg to to_lower()
# Use command substitution inside echo
echo -e "*** Lowercase version: \n$(to_lower ${var1})"

# Invoke the newest_matching_file 'b2*'
#
cd ~/Downloads
newest_matching_file '*csv'
number_of_lines $(newest_matching_file '*csv')
cd

#
