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
version="0.003"								## Version Year.Day
example_domain="megacorp.one" 				## Example domain
sleeptime=3								## Delay between queries
domain=$1 									## Get the domain
browser='Mozilla/5.0_(MSIE;_Windows_11)'	## Browser information for curl
gsite="site:$domain" 						## Google Site
ftdoc="filetype:doc"						## Filetype DOC (MsWord 97-2003)
ftdocx="filetype:docx"						## Filetype DOCX (MsWord 2007+)
ftpdf="filetype:pdf"						## Filetype PDF
ftsql="filetype:sql"						## Filetype SQL

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

### Function to get information about filetypes ### START
function GetFileTypes {
		result=""
		for start in `seq 0 10 10`; ##### Last number - quantity of possible answers
			do
				query="https://www.google.com/search?q=$gsite%20$1&start=$start&client=firefox-b-e"
				checkdata=$(echo;curl -sS -A $browser $query | grep -Eo "(http|https)://[a-zA-Z0-9./?=_-]*$domain/[a-zA-Z0-9./?=_-]*")
				if [ -z "$checkdata" ]
					then
						sleep $sleeptime; # Sleep to prevent banning
						break; # Exit the loop
					else
						result+=$checkdata;
						sleep $sleeptime; # Sleep to prevent banning
				fi
			done
			
		### Echo results
		if [ -z "$result" ] 
			then
				echo -e "\e[00;33m[\e[00m\e[01;31m-\e[00m\e[00;33m]\e[00m No results"
			else
				IFS=$'\n' sorted=($(sort -u <<<"${result[*]}")) # Sort the results with unique key
				echo "\e[00;33m[\e[00m\e[01;32m+\e[00m\e[00;33m]\e[00m File(s) found"
				for each in "${sorted[@]}"; do echo "\n\e[00;33m[\e[00m\e[01;32m+\e[00m\e[00;33m]\e[00m $each"; done
				 
		fi

		### Unset variables
		unset IFS sorted result checkdata query
}
### Function to get information about filetypes ### END

# Exploit
## DOC - start
echo -en "\n\e[00;33m[\e[00m\e[01;31m*\e[00m\e[00;33m]\e[00m" Checking DOC ... 
DOC=$(GetFileTypes $ftdoc)
echo -e $DOC
## DOC - end

## DOCX - start
echo -en "\n\e[00;33m[\e[00m\e[01;31m*\e[00m\e[00;33m]\e[00m" Checking DOCX ... 
DOCX=$(GetFileTypes $ftdocx)
echo -e $DOCX
## DOCX - end

## PDF - start
echo -en "\n\e[00;33m[\e[00m\e[01;31m*\e[00m\e[00;33m]\e[00m" Checking PDF ... 
PDF=$(GetFileTypes $ftpdf)
echo -e $PDF
## PDF - end

## SQL - start
echo -en "\n\e[00;33m[\e[00m\e[01;31m*\e[00m\e[00;33m]\e[00m" Checking SQL ... 
SQL=$(GetFileTypes $ftsql)
echo -e $SQL
## SQL - end
