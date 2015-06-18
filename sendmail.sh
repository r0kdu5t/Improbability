#!/bin/sh
# script: sendmail.sh
# author: Sean B. Straw
#
# This script is intended to be used for sandbox testing of procmail scripts
# so that we don't annoy the hell out of the universe because of some
# oversight in a script implementation.  It permits you to write the body of
# your procmail script just as you would use it in a live context, but by
# redefining $SENDMAIL in your sandbox wrapper, your included script invokes
# this instead of the real MTA.
#
# To use from procmail, simply redefine $SENDMAIL:
#
# SENDMAIL=/path/to/sendmail.sh
#
# Note: if you want to define the output filename dynamically from within
# your procmail config, you could define SENDMAIL above with the filename
# as the first argument and then change this script accordingly).
#
# This script uses 'lockfile', which is a supplemental procmail utility.
#

# set mailbox name, or perhaps it is a passed argument...
MBOXNAME=test.sent.mail

# create a lockfile 2 second delays, 6 retries.
if lockfile -2 -r 6 $MBOXNAME.lock; then
 ( echo X-MTA-Parameters: $@ ; echo X-MTA-Send-Date: `date` ; cat - ) >> $MBOXNAME 
 rm -f $MBOXNAME.lock
else
 # emit an error message to STDERR
 echo FAILURE OF $0 > /proc/self/fd/2
 # return a non-zero exit status to our caller so they know we failed
 exit 1
fi
