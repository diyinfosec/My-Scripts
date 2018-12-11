#!/bin/bash

#- Author: Ramprasad Ramshankar
#- Alias: diyinfosec
#- Date: 11-Dec-2018
#- Purpose: Takes rule_id (sid) as input and pretty prints (kinda) the rule. 
#- Goes hand in hand with the download script: https://github.com/diyinfosec/Shell-Scripts/blob/master/suricata_download_rules.sh
#- Language:  bash script

#- Usage: suricata_pretty_print_rule <rule-id>
#- Example: suricata_pretty_print_rule 2015755
#- You should come up with a better name for this script. 

#- Change the rule directory here
rule_dir="/tmp"

signature_id=$1

rule_data=$(grep -r --include "*.rules" $signature_id $rule_dir)
rule_file=$(echo $rule_data | cut -f1 -d":" | awk -F"/" '{print $NF}')

rule_desc=$(echo $rule_data | cut -f2- -d":" | tr ';' '\n')

clear
echo -e "\n========== Metadata ==========\n"
echo -e "Rule directory is : " $rule_dir
echo -e "Rule ID is : " $signature_id
echo -e "This rule is found in :" $(grep -l -r --include "*.rules" $signature_id $rule_dir | awk -F"/" '{print $NF}')
echo -e "\n========== BEGIN Rule ==========\n"
grep -r --include "*.rules" $signature_id $rule_dir | cut -f2- -d":" | tr ';' '\n'
echo -e "\n========== END Rule ==========\n"
