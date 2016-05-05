#!/bin/bash
## theatrix_functions.sh

# set variables 
declare -r TRUE=0
declare -r FALSE=1
declare -r PASSWD_FILE=/etc/passwd

##################################################################
# Purpose: Converts a string to lower case
# Arguments:
#   $1 -> String to convert to lower case
##################################################################
function to_lower() 
{
    local str="$@"
    local output     
    output=$(tr '[A-Z]' '[a-z]'<<<"${str}")
    echo $output
}
##################################################################
# Purpose: Display an error message and die
# Arguments:
#   $1 -> Message
#   $2 -> Exit status (optional)
##################################################################
function die() 
{
    local m="$1"    # message
    local e=${2-1}  # default exit status 1
    echo "$m" 
    exit $e
}
##################################################################
# Purpose: Return true if script is executed by the root user
# Arguments: none
# Return: True or False
##################################################################
function is_root() 
{
   [ $(id -u) -eq 0 ] && return $TRUE || return $FALSE
}

##################################################################
# Purpose: Return true $user exits in /etc/passwd
# Arguments: $1 (username) -> Username to check in /etc/passwd
# Return: True or False
##################################################################
function is_user_exits() 
{
    local u="$1"
    grep -q "^${u}" $PASSWD_FILE && return $TRUE || return $FALSE
}

# See :- http://stackoverflow.com/questions/5885934/bash-function-to-find-newest-file-matching-pattern
# Print the newest file, if any, matching the given pattern
# Example usage:
#   newest_matching_file 'b2*'
# WARNING: Files whose names begin with a dot will not be checked
function newest_matching_file
{
    # Use ${1-} instead of $1 in case 'nounset' is set
    local -r glob_pattern=${1-}

    if (( $# != 1 )) ; then
        echo 'usage: newest_matching_file GLOB_PATTERN' >&2
        return 1
    fi

    # To avoid printing garbage if no files match the pattern, set
    # 'nullglob' if necessary
    local -i need_to_unset_nullglob=0
    if [[ ":$BASHOPTS:" != *:nullglob:* ]] ; then
        shopt -s nullglob
        need_to_unset_nullglob=1
    fi

    newest_file=
    for file in $glob_pattern ; do
        [[ -z $newest_file || $file -nt $newest_file ]] \
            && newest_file=$file
    done

    # To avoid unexpected behaviour elsewhere, unset nullglob if it was
    # set by this function
    (( need_to_unset_nullglob )) && shopt -u nullglob

    # Use printf instead of echo in case the file name begins with '-'
    [[ -n $newest_file ]] && printf '%s\n' "$newest_file"

    return 0
}

##################################################################
# Purpose: Get number of lines in file
# Arguments:
#   $1 -> Filename of file
##################################################################
# Refer: http://stackoverflow.com/questions/12022319/bash-echo-number \
#  -of-lines-of-file-given-in-a-bash-variable-without-the-file-name
# NUMOFLINES=$(cat $JAVA_TAGS_FILE | wc -l )
function number_of_lines()
{
    cat $1 | wc -l
}