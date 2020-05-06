#!/bin/bash
# A script to enumerate web-sites using google dorks
# Author: Ivan Glinkin
# Contact: ivan.o.glinkin@gmail.com
# Release date: May 3, 2020

##### Defined colors
# [00;30m black 		\e[00m
# [00;31m red   		\e[00m
# [00;32m green 		\e[00m
# [00;33m orange 		\e[00m
# [00;34m blue 			\e[00m
# [00;35m purple 		\e[00m
# [00;36m light blue 	\e[00m
# [00;37m white 		\e[00m

# Variables
version="0.004"								## Version Year.Day
updatedate="May 06,2020"					## The date of the last update
example_domain="megacorp.one" 				## Example domain
sleeptime=5									## Delay between queries
domain=$1 									## Get the domain
browser='Mozilla/5.0_(MSIE;_Windows_11)'	## Browser information for curl
gsite="site:$domain" 						## Google Site
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
ftxml="filetype:xml"						## Filetype XML
filetypesarrays=($ftdoc $ftdocx $ftxls $ftxlsx $ftppt $ftpptx $ftmdb $ftpdf $ftsql $fttxt $ftxml)

# Clear the terminal
clear

# Header
echo -e "\n\e[00;33m#########################################################\e[00m"
echo -e "\e[00;33m#                                                       #\e[00m" 
echo -e "\e[00;33m#\e[00m" "\e[01;32m               Fast Google Dorks Scan                \e[00m" "\e[00;33m#\e[00m"
echo -e "\e[00;33m#                                                       #\e[00m" 
echo -e "\e[00;33m#########################################################\e[00m"
echo -e ""
echo -e "\e[00;33m# https://www.linkedin.com/in/IvanGlinkin/ | @IvanGlinkin\e[00m"
echo -e "\e[00;33m# Version:                 \e[00m" "\e[01;31m$version\e[00m"

# Check domain
	if [ -z "$domain" ] 
	then
		echo -e "\e[00;33m# Usage example:\e[00m" "\e[01;31m$0 $example_domain \e[00m\n"
		exit
	else
			echo -e "\e[00;33m# Get information about:   \e[00m" "\e[01;31m$domain\e[00m"
			echo -e "\e[00;33m# Delay between queries:   \e[00m" "\e[01;31m$sleeptime\e[00m" "\e[00;33msec\e[00m"
	fi

### Function to get information about filetype ### START
function GetFileType {
		result="";
		for start in `seq 0 10 10`; ##### Last number - quantity of possible answers
			do
				query=$(echo; curl -sS -A $browser "https://www.google.com/search?q=$gsite%20$1&start=$start&client=firefox-b-e")

				checkban=$(echo $query | grep -io "https://www.google.com/sorry/index")
				if [ "$checkban" == "https://www.google.com/sorry/index" ]
				then 
					echo -e "Google thinks you are the robot and has banned you;) How dare he? So, you have to wait some time to unban or change your ip!"; 
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
				echo -e "\e[00;33m[\e[00m\e[01;31m-\e[00m\e[00;33m]\e[00m No results"
			else
				IFS=$'\n' sorted=($(sort -u <<<"${result[@]}" | tr " " "\n")) # Sort the results with unique key
				echo -e " "
				for each in "${sorted[@]}"; do echo -e "     \e[00;33m[\e[00m\e[01;32m+\e[00m\e[00;33m]\e[00m $each"; done
				 
		fi

		### Unset variables
		unset IFS sorted result checkdata checkban query
}
### Function to get information about filetype ### END


### Function to print information about specific filetype ### START
function PrintFiletypeResults {
	for type in $@; 
		do echo -en "\n\e[00;33m[\e[00m\e[01;31m*\e[00m\e[00;33m]\e[00m" Checking $(echo $type | cut -d ":" -f 2 | tr '[:lower:]' '[:upper:]') ... 
		GetFileType $type 
	done
}
### Function to print information about specific filetype ### END

# Exploit
PrintFiletypeResults "${filetypesarrays[@]}";
