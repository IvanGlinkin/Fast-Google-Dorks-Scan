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
version="2.282"			## Version Year.Day
updatedate="March 9,2023"	## The date of the last update
example_domain="megacorp.one" 	## Example domain
sleeptime=9			## Delay between queries, in seconds
domain=$1 			## Get the domain
browser='Mozilla'		## Browser information for curl
gsite="site:$domain" 		## Google Site

## Colors
RED=`echo -n '\e[00;31m'`;
RED_BOLD=`echo -n '\e[01;31m'`;
GREEN=`echo -n '\e[00;32m'`;
GREEN_BOLD=`echo -n '\e[01;32m'`;
ORANGE=`echo -n '\e[00;33m'`;
BLUE=`echo -n '\e[01;36m'`;
WHITE=`echo -n '\e[00;37m'`;
CLEAR_FONT=`echo -n '\e[00m'`;

## Login pages
lpadmin="inurl:admin"
lplogin="inurl:login"
lpadminlogin="inurl:adminlogin"
lpcplogin="inurl:cplogin"
lpweblogin="inurl:weblogin"
lpquicklogin="inurl:quicklogin"
lpwp1="inurl:wp-admin"
lpwp2="inurl:wp-login"
lpportal="inurl:portal"
lpuserportal="inurl:userportal"
lploginpanel="inurl:loginpanel"
lpmemberlogin="inurl:memberlogin"
lpremote="inurl:remote"
lpdashboard="inurl:dashboard"
lpauth="inurl:auth"
lpexc="inurl:exchange"
lpfp="inurl:ForgotPassword"
lptest="inurl:test"
lgit="inurl:.git"
loginpagearray=($lpadmin $lplogin $lpadminlogin $lpcplogin $lpweblogin $lpquicklogin $lpwp1 $lpwp2 $lpportal $lpuserportal $lploginpanel $memberlogin $lpremote $lpdashboard $lpauth $lpexc $lpfp $lptest $lgit)

## Filetypes
ftdoc="filetype:doc"						## Filetype DOC (MsWord 97-2003)
ftdocx="filetype:docx"						## Filetype DOCX (MsWord 2007+)
ftxls="filetype:xls"						## Filetype XLS (MsExcel 97-2003)
ftxlsx="filetype:xlsx"						## Filetype XLSX (MsExcel 2007+)
ftppt="filetype:ppt"						## Filetype PPT (MsPowerPoint 97-2003)
ftpptx="filetype:pptx"						## Filetype PPTX (MsPowerPoint 2007+)
ftmdb="filetype:mdb"						## Filetype MDB (Ms Access)
ftpdf="filetype:pdf"						## Filetype PDF
ftsql="filetype:sql"						## Filetype SQL
fttxt="filetype:txt"						## Filetype TXT
ftrtf="filetype:rtf"						## Filetype RTF
ftcsv="filetype:csv"						## Filetype CSV
ftxml="filetype:xml"						## Filetype XML
ftconf="filetype:conf"						## Filetype CONF
ftdat="filetype:dat"						## Filetype DAT
ftini="filetype:ini"						## Filetype INI
ftlog="filetype:log"						## Filetype LOG
ftidrsa="index%20of:id_rsa%20id_rsa.pub"			## File ID_RSA
ftpy="filetype:py"						## Filetype Python
ftphtml="filetype:html"						## Filetype HTML
ftpsh="filetype:sh"						## Filetype Bash 
ftpodt="filetype:odt"						## Filetype ODT
ftpkey="filetype:key"						## Filetype KEY
ftpsgn="filetype:sign"						## Filetype SIGN
ftpmd="filetype:md"						## Filetype MD 
ftpold="filetype:old"						## Filetype OLD 
ftpbin="filetype:bin"						## Filetype BIN 

filetypesarray=($ftdoc $ftdocx $ftxls $ftxlsx $ftppt $ftpptx $ftmdb $ftpdf $ftsql $fttxt $ftrtf $ftcsv $ftxml $ftconf $ftdat $ftini $ftlog $ftidrsa $ftpy $ftphtml $ftpsh $ftpodt $ftpkey $ftpsgn $ftpmd $ftpold $ftpbin )

## Directory traversal
dtparent='intitle:%22index%20of%22%20%22parent%20directory%22' 	## Common traversal
dtdcim='intitle:%22index%20of%22%20%22DCIM%22' 			## Photo
dtftp='intitle:%22index%20of%22%20%22ftp%22' 			## FTP
dtbackup='intitle:%22index%20of%22%20%22backup%22'		## BackUp
dtmail='intitle:%22index%20of%22%20%22mail%22'			## Mail
dtpassword='intitle:%22index%20of%22%20%22password%22'		## Password
dtpub='intitle:%22index%20of%22%20%22pub%22'			## Pub
dirtravarray=($dtparent $dtdcim $dtftp $dtbackup $dtmail $dtpassword $dtpub)

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
	echo -e "$ORANGE[ ! ] Get information about:   $CLEAR_FONT $RED_BOLD$domain$CLEAR_FONT"
	echo -e "$ORANGE[ ! ] Delay between queries:   $CLEAR_FONT $RED_BOLD$sleeptime$CLEAR_FONT$ORANGE sec$CLEAR_FONT\n"
fi

### Function to get information about site ### START
function Query {
	result="";
	for start in `seq 0 10 40`; ##### Last number - quantity of possible answers
		do
			query=$(echo; curl -sS -b "CONSENT=YES+srp.gws-20211028-0-RC2.es+FX+330" -A $browser "https://www.google.com/search?q=$gsite%20$1&start=$start&client=firefox-b-e")

			checkban=$(echo $query | grep -io "https://www.google.com/sorry/index")
			if [ "$checkban" == "https://www.google.com/sorry/index" ]
			then 
				echo -e "$RED_BOLD[ ! ]$CLEAR_FONT Google thinks you are the robot and has banned you;) How dare he? So, you have to wait some time to unban or change your ip!"; 
				exit;
			fi
				
			checkdata=$(echo $query | grep -Eo "(http|https)://[a-zA-Z0-9./?=_~-]*$domain/[a-zA-Z0-9./?=_~-]*")
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
		do echo -en "$BLUE[ > ]$CLEAR_FONT" Checking $(echo $dirtrav | cut -d ":" -f 2 | tr '[:lower:]' '[:upper:]' | sed "s@+@ @g;s@%@\\\\x@g" | xargs -0 printf "%b") 
		Query $dirtrav 
	done
echo " "
}
### Function to print the results ### END

# Exploit
echo -e "$GREEN_BOLD[ * ] Checking Login Page:$CLEAR_FONT"; PrintTheResults "${loginpagearray[@]}";
echo -e "$GREEN_BOLD[ * ] Checking specific files:$CLEAR_FONT"; PrintTheResults "${filetypesarray[@]}";
echo -e "$GREEN_BOLD[ * ] Checking path traversal:$CLEAR_FONT"; PrintTheResults "${dirtravarray[@]}";
