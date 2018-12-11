#!/bin/bash

#- Author: Ramprasad Ramshankar 
#- Alias: diyinfosec
#- Date: 11-Dec-2018
#- Purpose: To download Suricata open source Rule files from emergingthreats.net
#- Language:  bash script

#- As on date (11-Dec-2018), this is the URL hosting Suricata open rules
suricata_rule_url="https://rules.emergingthreats.net/open/suricata/rules/"

#- Get the names of the ".rules" files from the $suricata_rule_url and subsequently download them 
#- curl options used:
#- -s = Will supress curl logging output
#- -o = Will redirect downloaded content to the specified output file
for rule_file_name in $(curl -s $suricata_rule_url | sed -n 's/.*href="\([^"]*\).*/\1/p' | grep ".rules$")
do
	echo "Downloading " ${suricata_rule_url}$rule_file_name

	#- Note: Existing files with the same name will be over-written
	curl -s -o $rule_file_name ${suricata_rule_url}$rule_file_name

	#- Using echo with -e flag to allow interpretation of \n as a newline character
	echo -e "Completed!\n"
done
