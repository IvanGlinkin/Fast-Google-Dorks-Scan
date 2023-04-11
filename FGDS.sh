#!/bin/bash

############################################################################
# The OSINT project, the main idea of which is to collect all the possible #
# Google dorks search combinations and to find the information about the   #
# specific web-site: common admin panels, the widespread file types and    #
# path traversal. The 100% automated.					   #
############################################################################
# Author:   Ivan Glinkin                                                   #
# Contact:  mail@ivanglinkin.com                                           #
# Twitter:  https://twitter.com/glinkinivan                                #
# LinkedIn: https://www.linkedin.com/in/ivanglinkin/                       #
############################################################################

# Variables
## General
version="2.335"			## Version Year.Day
updatedate="April 5,2023"	## The date of the last update
releasedate="May 3, 2020"	## The date of release
example_domain="megacorp.one" 	## Example domain
domain=$1 			## Get the domain
gsite="site:$domain" 		## Google Site
folder="outputs"		## Output folder name

## Colors
RED=`echo -n '\e[00;31m'`;
RED_BOLD=`echo -n '\e[01;31m'`;
GREEN=`echo -n '\e[00;32m'`;
GREEN_BOLD=`echo -n '\e[01;32m'`;
ORANGE=`echo -n '\e[00;33m'`;
BLUE=`echo -n '\e[01;36m'`;
WHITE=`echo -n '\e[00;37m'`;
CLEAR_FONT=`echo -n '\e[00m'`;

# Read login page URLs from payload.txt into an array
while IFS= read -r line; do
    loginpagearray+=("$line")
done < <(cat login_pages.txt)

# File Types
while IFS= read -r line; do
    filetypesarray+=("$line")
done < <(cat file_types.txt)

## Directory traversal
while IFS= read -r line; do
	dirtravarray+=("$line")
done < <(cat directory_traversal.txt)

## User-agents
while IFS= read -r line; do
	useragentsarray+=("$line")
done < <(cat user_agents.txt)
useragentlength=${#useragentsarray[@]};

# Header
echo -e "";
echo -e "$ORANGE╔═══════════════════════════════════════════════════════════════════════════╗$CLEAR_FONT";
echo -e "$ORANGE║\t\t\t\t\t\t\t\t\t    ║$CLEAR_FONT";
echo -e "$ORANGE║$CLEAR_FONT$GREEN_BOLD\t\t\t    Fast Google Dorks Scan \t\t\t    $CLEAR_FONT$ORANGE║$CLEAR_FONT";
echo -e "$ORANGE║\t\t\t\t\t\t\t\t\t    ║\e[00m";
echo -e "$ORANGE╚═══════════════════════════════════════════════════════════════════════════╝$CLEAR_FONT";
echo -e "";
echo -e "$ORANGE[ ! ] https://www.linkedin.com/in/IvanGlinkin/ | @glinkinivan$CLEAR_FONT";
echo -e "$ORANGE[ ! ] Version: $version $CLEAR_FONT";
echo -e "";

# Check domain
if [ -z "$domain" ] 
then
	echo -e "$ORANGE[ ! ] Usage example:$CLEAR_FONT$RED_BOLD bash $0 $example_domain $CLEAR_FONT"
	exit
else
	### Check if the folder for outputs is existed. IF not, create a folder
	if [ ! -d "$folder" ]; then mkdir "$folder"; fi
	## Create an output file
	filename=$(date +%Y%m%d_%H%M%S)_$domain.txt
	
	echo -e "$ORANGE[ ! ] Get information about:   $CLEAR_FONT $RED_BOLD$domain$CLEAR_FONT"
	echo -e "$ORANGE[ ! ] Output file is saved:    $CLEAR_FONT $RED_BOLD$(pwd)/$folder/$filename$CLEAR_FONT"
fi

### Function to get information about the site ### START
function Query {
	result="";
	for start in `seq 0 10 40`; ##### Last number - quantity of possible answers
		do
			index=$(( RANDOM % useragentlength ))
			randomuseragent=${useragentsarray[$index]}			
			
			query=$(echo; curl -sS -b "CONSENT=YES+srp.gws-20211028-0-RC2.es+FX+330" -A "\"$randomuseragent\"" "https://www.google.com/search?q=$gsite%20$1&start=$start&client=firefox-b-e")

			checkban=$(echo $query | grep -io "https://www.google.com/sorry/index")
			if [ "$checkban" == "https://www.google.com/sorry/index" ]
			then 
				echo -e "\n\t$RED_BOLD[ ! ]$CLEAR_FONT Google thinks you are the robot and has banned you;) How dare he? So, you have to wait some time to unban or change your ip!"; 
				exit;
			fi
				
			checkdata=$(echo $query | grep -Eo "(http|https)://[a-zA-Z0-9./?=_~-]*$domain/[a-zA-Z0-9./?=_~-]*")
			
			sleeptime=$(shuf -i8-12 -n1);
			if [ -z "$checkdata" ]
				then
					sleep $sleeptime; # Sleep to prevent banning
					break; # Exit the loop
				else
					result+="$checkdata ";
					sleep $sleeptime; # Sleep to prevent banning
			fi
	done

	### Echo results
	if [ -z "$result" ] 
		then
			echo -e "\n\t$RED_BOLD[ - ]$CLEAR_FONT No results"
		else
			IFS=$'\n' sorted=($(sort -u <<<"${result[@]}" | tr " " "\n")) # Sort the results
			echo -e " "
			for each in "${sorted[@]}"; do echo -e "\t$GREEN[ + ]$CLEAR_FONT $each"; done
	fi

	### Unset variables
	unset IFS sorted result checkdata checkban query
}
### Function to get information about site ### END

### Function to print the results ### START
function PrintTheResults {
	for dirtrav in $@; 
		do
		clearrequest=$(echo $dirtrav | sed 's/+/ /g;s/%\(..\)/\\x\1/g;' | xargs -0 printf '%b');
		echo -en "$BLUE[ > ]$CLEAR_FONT" Checking $(echo $dirtrav | cut -d ":" -f 2 | tr '[:lower:]' '[:upper:]' | sed "s@+@ @g;s@%@\\\\x@g" | xargs -0 printf "%b") $(echo "   $ORANGE[ Google query:"$CLEAR_FONT$BLUE $gsite $clearrequest$CLEAR_FONT "$ORANGE]$CLEAR_FONT")
		Query $dirtrav 
	done
echo " "
}
### Function to print the results ### END

# Exploit
echo -e "$GREEN_BOLD[ * ] Checking Login Page:$CLEAR_FONT"; PrintTheResults "${loginpagearray[@]}" | tee -a $folder/$filename;
echo -e "$GREEN_BOLD[ * ] Checking specific files:$CLEAR_FONT"; PrintTheResults "${filetypesarray[@]}" | tee -a $folder/$filename;
echo -e "$GREEN_BOLD[ * ] Checking path traversal:$CLEAR_FONT"; PrintTheResults "${dirtravarray[@]}" | tee -a $folder/$filename;
