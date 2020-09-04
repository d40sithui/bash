# write your code in Bash
#!bin/bash

access_list=(); #array of access.log file names
error_list=(); #array of error.log file names

#greps all access.log file names and assign to a list file
ls | grep "access.log*" > access.list

#assigns each file name as an array element
file="access.list"
while read -r line
do
   # printf "line: $line \n"
    access_list+=($line);
done < $file

#gets array length
len=${#access_list[@]};
#lastkey=$(expr $len - 1);
#printf "access list length: $len\n";
#printf "access list last element:"${access_list[$lastkey]}" \n"

#gets the highest suffix/log number extension
highest_log_num=0;
for ((i=0;i<$len;i++));
    do
        current_log_name=${access_list[$i]};
        #printf "current_log_name: $current_log_name\n";
        current_log_num=$(echo "${access_list[$i]}" | sed 's/[^0-9]*//g')
        #printf "current_log_num: $current_log_num\n"
        if [[ $current_log_num -gt $highest_log_num ]]
        then
            highest_log_num=$current_log_num
        fi
     done
     
#printf "highest_log_num: $highest_log_num\n"

#once we get the highest log file we can work backwards and begin dispensing mv commands
for ((i=$highest_log_num;i>0;i--));
do
    iplus1=$(expr $i + 1);
    mv -f "access.log.$i" "access.log.$iplus1";
done

#then we up the log file without the number extension/suffix
mv access.log access.log.1

#finally, create an empty error.log file
touch access.log

#loops through all access_list array, starting with the last key going backwards, perform a mv
#for ((i=$lastkey; i>=0; i--));
    #do
        #printf "${access_list[$i]}\n";
        #current=$(expr $i + 1);
        #if [[ ${error_list[$i]} = *?[0-9] ]];
            #then
                #mv -f "${access_list[$i]}" "error.log.$current";
        #fi
    #done

#cleanup
rm -rf access.list

#################################
#The below is the same logic applied for error.log files
#################################

#greps all error.log files and assign to a list file
ls | grep "error.log*" > error.list

#assigns each error.log file as an array element
file="error.list"
while read -r line
do
   # printf "line: $line \n"
    error_list+=($line);
done < $file

#gets length of error_list array
len=${#error_list[@]};
#lastkey=$(expr $len - 1);
#printf "error list length: $len\n";
#printf "error list last element: ${error_list[$lastkey]} \n"

#gets the highest suffix/number extension
highest_log_num=0;
for ((i=0;i<$len;i++));
    do
        current_log_name=${error_list[$i]};
        #printf "current_log_name: $current_log_name\n";
        current_log_num=$(echo "${error_list[$i]}" | sed 's/[^0-9]*//g')
        #printf "current_log_num: $current_log_num\n"
        if [[ $current_log_num -gt $highest_log_num ]]
        then
            highest_log_num=$current_log_num
        fi
     done
     
#printf "highest_log_num: $highest_log_num\n"

#once we get the highest log file we can work backwards and begin dispensing mv commands
for ((i=$highest_log_num;i>0;i--));
do
    iplus1=$(expr $i + 1);
    mv -f "error.log.$i" "error.log.$iplus1";
done

#then we up the log file without the number extension/suffix
mv error.log error.log.1

#finally, create an empty error.log file
touch error.log

#cleanup
rm -rf error.list
echo "end";