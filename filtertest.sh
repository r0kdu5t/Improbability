#!/bin/sh
# (I should be chmod +x)

# delete the log from previous run
rm testing.log

# run the test filter
formail -s procmail -m testing.rc < my_message_file

# view the log
less testing.log

# edit the test filter
nano -w test_filter.rc

# From the command line do -
# formail -s procmail -m <name_of_test_recipe>.rc < [name_of_mail_message_file]
#
