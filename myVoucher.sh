#!/bin/bash
## myVoucher.sh
#
##################################################################
# Purpose: Take pfsense captive portal voucher roll csv file
#           add header lines and duration value datum.
# Arguments:
#   Still thinking about it!
##################################################################

# Load the  myfunctions.sh 
# Local path is /home/andrew/Working/Improbability/theatrix_functions.sh
. /home/andrew/Working/Improbability/theatrix_functions.sh

# Define local variables
DLDIR="/home/andrew/Downloads"
HEADER1=""
HEADER2=""
DURATION=120
LABEL_NAME="voucher.csv" # Glabels template uses this for data input.
## cd ~/Downloads/ && echo "Voucher,Duration" >> /tmp/voucher.csv && \
## tail -n 12 vouchers_twilight_zone_roll6.csv | sed 's/$/,120/' >> /tmp/voucher.csv \
## && cat /tmp/voucher.csv && rm vouchers_twilight_zone_roll5.csv # Adjust for csv file name
