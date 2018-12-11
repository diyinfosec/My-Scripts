#!/bin/bash

#- Author: Ramprasad Ramshankar
#- Alias: diyinfosec
#- Date: 11-Dec-2018
#- Purpose: Numerically lists the files in the directory. User can select a file based on the list number and use the file for further processing
#- Usecase: Useful for log analysis when you have a number of log files in a directory and you want to just parse/query one of them
#- Language:  bash script

#- Set the directory name
log_file_dir="/tmp"

#- Set the file extension. You can set any regexp below to search for files in $log_file_dir
log_file_extension="*.log"

#- Variable for temporary file name
tmp_lst_file="/tmp/tmp_$$.lst"

#- Removing the temporary file if it already exists
/bin/rm -f $tmp_lst_file

#- Writing the file list to the temporary file
ls -1rt $log_file_dir/$log_file_extension > $tmp_lst_file


#- Printing file list for the user to select
file_counter=0
error_flg="N"
for files in `cat $tmp_lst_file`
do
        file_counter=$((file_counter+1))
        echo $file_counter") "$files
done

#- User can input the file number based on the above list 
echo "Which file do you want to search?" 
read file_num

#- Validating user input if it's numeric and if the number is in the range of the file list.
re='^[0-9]+$'
if ! [[ $file_num =~ $re ]] ; then
        error_flg="Y"
elif [ $file_num -gt $file_counter -o $file_num -le 0 ]; then
        echo "combined if"
        error_flg="Y"
fi

#- Getting the filename from the list. If the user input is invalid then the last file is selected.
if [ $error_flg == "Y" ]; then
        echo "error: Invalid input. Defaulting to last file"
        selected_log_file=$(tail -1 $tmp_lst_file)
else      
        selected_log_file=$(head -$file_num $tmp_lst_file | tail -1)
fi      

#- Printing the filename. If you want to do any additional processing on the selected file then you can continue from here
echo $selected_log_file
