#!/bin/bash
#### Description: Post installation script to allow automation of Operating System recovery
#### Note:
#### References:
#### Comment:
####
#### #### Cobbled together by: Andrew J. Sands - andrew@theatrix.org.nz on or about 7 September 2014
####

## VARIABLES
LOG_FILE=/tmp/$(basename $0)
DESKTOPFILE=""
CLICKMEFILE=""
USERFILE=""
OUTFILE=""


## Function to write to the Log file
#####################################
## Set LOG_FILE if required before calling
write_log() {
	while read text
	do
		LOG_TIME=`date "+%Y-%m-%d %H:%M:%S"`
		# If log file is not defined, just echo the output
		if [ "$LOG_FILE" == "" ]; then
			echo $LOG_TIME": $text";
		else
			LOG=$LOG_FILE.$(date +%Y%m%d).log
			touch $LOG
			if [ ! -f $LOG ]; then
				echo "ERROR!! Cannot create log file $LOG. Exiting.";
				exit 1;
			fi
			echo $LOG_TIME": $text" | tee -a $LOG;
		fi
	done
}

## Function: Write out dot desktop file
#######################################
##
alphaDesktop() {
#
	DESKTOPFILE=/tmp/theatrix.desktop
	cat <<- __EOF__ > $DESKTOPFILE
	[Desktop Entry]
	Version=1.0
	Exec=/usr/local/bin/theatrixClickMeFirst.sh
	Icon=/usr/share/icons/gnome/48x48/status/software-update-urgent.png
	Name=ClickMeFirst
	GenericName=ClickMeFirst
	Comment=Theatrix Intranet User Setup
	Encoding=UTF-8
	Terminal=false
	Type=Application
	Categories=Application;Utility;
	__EOF__
	echo "Created theatrix.desktop - OK" | write_log
}

bravoClickMeFirst() {
    # Here document containing the body of the generated script.
    CLICKMEFILE=/tmp/theatrixClickMeFirst.sh
    (
    cat <<-'EOF'
    #!/bin/bash
   
    #### Description: Script to allow user to make configuration changes in consistent manner.
    #### Note:
    #### References:
    #### Comment:
    ####
    
    alterPublic() {
    # Change  Public from local folder to shared folder. 
        # Check if shared directory exists
        PUBLICSHARE=/home/shared
        DIRECTORY=$HOME/Public
        # Check if change has already been made. Check if $USER $DIRECTORY is a link!
        if [[ -L ${DIRECTORY} ]]; then
            # echo "true"
            zenity --error --title="Task Error" --text="Changes already made for $USER."
        else
            #echo "false"
            zenity --info --title="Info Notice" --text="Changes need to be made for $USER."
            # Check if $PUBLICSHARE is a directory!
            if [[ -d "${PUBLICSHARE}" ]] ; then
                #echo "true"
                echo "Removing local Public folder and creating link to shared Public folder."
                rm -rf Public && ln -s /home/shared Public
                zenity --info --title="Public Folder Access" --text="Changes have been applied.\n\n$USER now can access to Public Shared folder."
            else
                #echo "false"
                zenity --error --title="Task Error" --text="$PUBLICSHARE folder does not exist!\n\n\tAdvise Administrator Immediately!"
            fi
        fi
        #ls -l $PUBLICSHARE
    }
    doGet() {
    # log - gsettings snapshot
        #FILE=$HOME/Desktop/gsettings_list.$(date +%d%b%Y%R).txt
        FILE=/tmp/gsettings_list.$(date +%d%b%Y%R).txt
        gsettings list-recursively > $FILE
    }
    doSet() {
    # log - changes to desktop settings
        gsettings set org.cinnamon.desktop.lockdown disable-user-switching true
        gsettings set org.cinnamon.SessionManager logout-prompt false
    }
    
    ## Main
    zenity --info --title="User Configuration" --text="Changes need to be applied to configure settings.\n\nPlease, Click 'OK' to continue."
    alterPublic
    doGet
    
    exit 0
EOF
    ) > $CLICKMEFILE
    echo "Created ClickMeFirst shell script." | write_log
}

charlieUserNames() {
    USERFILE=/tmp/yourfilehere # Change the name later. Use variable?
	# Set to ignore tabs. Are there tabs?
	cat <<- __EOF__ > $USERFILE
	Homer Simpson
	Marge Simpson
	Bart Simpson
	Maggie Simpson
	Snowball Simpson
	__EOF__
    echo "Wrote usernames file." | write_log	        
}

deltaDealWithUsers() {
#
    USERFILE=/tmp/yourfilehere # Change the name later. Use variable?
    OUTFILE=/tmp/out.csv
    touch $OUTFILE  # Consider a check and a warning flag, If file exists??? Make file with $(date) command!!
    echo "Fullname,Username,Password" >> $OUTFILE
    while read name
    do
        pass=$( cat /dev/urandom | tr -dc _A-Z-a-z-0-9 | head -c8 )
        echo "This is the full name : $name" | write_log
        user="$(echo $( cut -d ' ' -f 1 <<< "$name" ) | tr '[A-Z]' '[a-z]')"
        echo "This will be the user name : $user" | write_log
        echo "Fullname : $name, Username : $user"
        sudo useradd -m -G users -d /home/$user -s /bin/bash -c "$name" -p $(mkpasswd "$pass") $user
        echo "$name,$user,$pass" >> $OUTFILE
        echo "Added: $user,$name" | write_log
        #
    done < $USERFILE
    
}
foxtrotDeployDesktop() {
#
    if [[ -f ${DESKTOPFILE} ]]; then
        echo "File exists. Now checking if destination exists."
        DT_DEST=/etc/skel/Desktop/
            if [[ -d ${DT_DEST} ]]; then
                echo "$DT_DEST : Yes, I exist!"
                # PROBABLY NEED ROOT PRIVILEGES!!
                echo "sudo mv -v $DESKTOPFILE $DT_DEST"
                echo "Moved $DESKTOPFILE to $DT_DEST" | write_log
                echo "sudo chmod ug+x $DT_DEST${DESKTOPFILE##?????}"
                echo "Made executable : $DT_DEST${DESKTOPFILE##?????}" | write_log
                
            else
                echo "$DT_DEST : No, I do not EXIST! Action needs to be taken!"
                # PROBABLY NEED ROOT PRIVILEGES!!
                echo "sudo mkdir -p $DT_DEST"
                echo "Created : $DT_DEST" | write_log
                echo "sudo mv -v $DESKTOPFILE $DT_DEST"
                echo "Moved $DESKTOPFILE to $DT_DEST" | write_log
                echo "sudo chmod ug+x $DT_DEST${DESKTOPFILE##?????}"
                echo "Made executable : $DT_DEST${DESKTOPFILE##?????}" | write_log
            fi
    else
        echo "File does not exist. Moving on."
    fi
    #sudo ls -la /etc # Command line test?
    echo "Completed action dot desktop deployment." | write_log
}

## Main
if [ $tDEBUG ]; then
   #echo $LOG_FILE
   echo "DEBUG: ON"
   echo "Clean Up - Remove testing files." | write_log
   rm /tmp/*.desktop
   rm /tmp/theatrixClickMeFirst.sh
   rm /tmp/out.csv
   #
fi

alphaDesktop
bravoClickMeFirst
#charlieUserNames
deltaDealWithUsers

if [ tDEBUG ]; then
   echo "LOG_FILE    : $LOG_FILE"
   echo "DESKTOPFILE : $DESKTOPFILE"
   echo "CLICKMEFILE : $CLICKMEFILE"
   echo "USERFILE    : $USERFILE"
   echo "OUTFILE     : $OUTFILE"
fi

foxtrotDeployDesktop

exit 0
# EOF_theatrixPostInstall.sh
#
# export FILE=names; while read line; do echo "This is a line : $line"; done < $FILE

