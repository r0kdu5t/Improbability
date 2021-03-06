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

## Internal do_debug function
function do_debug () {
	## DEBUG output printing of variables
	echo $DLDIR
	echo $HEADER1
	echo $HEADER2
	echo $NUMVOUCHER
	echo $DURATION
	echo $LABEL_SET_NAME
	echo $LABEL_SET_TYPE
	echo $WORKFILE
}

# Define local variables
DLDIR="/home/andrew/Downloads"
HEADER1="Voucher"
HEADER2="Duration"
NUMVOUCHER=12
DURATION=120
LABEL_SET_NAME="voucher" # Glabels template uses this for data import.
LABEL_SET_TYPE=".csv"
OUTDIR="/tmp/"
OUTFILENAME=$OUTDIR$LABEL_SET_NAME$LABEL_SET_TYPE
## cd ~/Downloads/ && echo "Voucher,Duration" >> /tmp/voucher.csv && \
## tail -n 12 vouchers_twilight_zone_roll6.csv | sed 's/$/,120/' >> /tmp/voucher.csv \
## && cat /tmp/voucher.csv && rm vouchers_twilight_zone_roll5.csv # Adjust for csv file name

## Change to download directory
cd $DLDIR

## Create output file - in /tmp 
touch $OUTFILENAME

## Insert headers into output file
echo "$HEADER1,$HEADER2" >> $OUTFILENAME

## Find source data file 
WORKFILE=$(newest_matching_file '*'${LABEL_SET_TYPE})

## Add DURATION data value to each line
tail -n $NUMVOUCHER $WORKFILE | sed -e s/$/",${DURATION}"/ >> $OUTFILENAME
### Refer: http://www.linuxquestions.org/questions/programming-9 \
###        /sed-doesn't-accept-$variable-in-bash-script-325935/

## Output completed action to screen for review
### TODO - Add description of what's just be chucked onto screen.
cat $OUTFILENAME

### TODO - Follow with blank line and instructions / reminder of what to do next!
## Test do_debug function
#do_debug

## Tidy Up at the end. Remove workfile and return to home directory.
#rm $WORKFILENAME
cd
