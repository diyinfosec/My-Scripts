#!/bin/bash

#- Author: Ramprasad Ramshankar
#- Alias: diyinfosec
#- Date: 22-May-2020
#- Purpose: To run a few Elasticsearch GET requests
#- Usecase: Useful for making some adhoc queries to ES
#- Language:  bash script

#- Set elastic search properties
es_proto="http"
es_ip="192.168.124.168"
es_port="9200"
es_url_prefix=$es_proto"://"$es_ip":"$es_port
es_adm_endpoint="/_cat"
es_url_suffix='?pretty=true'
es_url_suffix=''
es_adm_url=$es_url_prefix$es_adm_endpoint$es_url_suffix
echo "Admin URL is: "$es_adm_url

#- Set the working directory
log_file_dir="/tmp"

#- Variable for temporary file name
tmp_lst_file="/tmp/tmp_$$.lst"

#- Removing the temporary file if it already exists
/bin/rm -f $tmp_lst_file

#- Writing the file list to the temporary file
curl -sX GET $es_adm_url | grep -v ^= | grep -v \{ > $tmp_lst_file


#- Validating user input if it's numeric and if the number is in the range of the file list.
re='^[0-9]+$'
continue_flg="Y"
endpoint_num=0

while [ $continue_flg = "Y" ]
do
        clear
        #- Printing file list for the user to select
        file_counter=0
        continue_flg="N"
        echo "====================================================="
        echo "List of available Elasticsearch endpoints"
        echo "IP address:"$es_ip
        echo "Port number:"$es_port
        echo "Protocol:"$es_proto
        echo "====================================================="
        for files in `cat $tmp_lst_file`
        do
                file_counter=$((file_counter+1))
                echo $file_counter") "$files
        done

        echo "q|Q) quit"

        if [[ $endpoint_num == "Q" || $endpoint_num == "q" ]]; then
                continue_flg="N"
                exit 0
        elif ! [[ $endpoint_num =~ $re ]] ; then
                continue_flg="Y"
        elif [ $endpoint_num -gt $file_counter -o $endpoint_num -le 0 ]; then
                continue_flg="Y"
        else
                selected_endpoint=$(head -$endpoint_num $tmp_lst_file | tail -1)

                es_url=$es_url_prefix$selected_endpoint$es_url_suffix
                echo "============================================================================="
                echo "You selected" $selected_endpoint
                echo "Endpoint queried:" $es_url
                echo "=============RESULT-BEGIN===================================================="
                curl -sX GET $es_url
                echo "=============RESULT-END======================================================"
                continue_flg="Y"
        fi
        #- User can input the endpoint number based on the above list
        echo "Which endpoint do you want to query?"
        read endpoint_num
        echo "End of input is"$endpoint_num
        echo "End of input, error flag is "$continue_flg

done
