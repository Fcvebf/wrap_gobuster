#!/bin/bash
  
Help()
{
   echo "Wrapper script for gobuster"
   echo
   echo "Syntax: wrap_gobuster.sh -u URLs_file  -w wordlist [ -t threads | -d results_folder | -h ]"
   echo "options:"
   echo "-u     the file with the target URLs"
   echo "-w     the wordlist"
   echo "-t     the threads"   
   echo "-d     the directory where to write the results"
   echo "-h     print the help"
   echo
   exit
}

results_folder="./results"
threads=10
while getopts u:w:t:d:h flag
do
    case "${flag}" in
        u) URLs_file=$OPTARG;;
        w) wordlist=$OPTARG;;
        t) threads=$OPTARG;;
        d) results_folder=$OPTARG;;
        h) Help;;
       \?) # Invalid option
          echo "Error: Invalid option"
          exit;;
    esac
done
  
shift "$(( OPTIND - 1 ))"
if [ -z "$URLs_file" ] || [ -z "$wordlist" ]; then
        echo 'Missing -u/-w parameter'
        Help
fi
  
[ ! -f $URLs_file ] && { echo "$URLs_file does not exist."; exit; }
[ ! -f $wordlist ] && { echo "$wordlist does not exist."; exit; } 
[ -d $results_folder ] || mkdir $results_folder
 
 

#the main loop
i=1
total=$(wc -l $URLs_file|awk '{print $1}')
 
while IFS= read -r URL
do
    log=`echo $URL|cut -d '/' -f3`
    log_file="$results_folder/$log.log"
     echo "${log}.log"
    gobuster dir -k -u $URL -w $wordlist -x .html,.jsp,.jsf,.php,.txt,.zip -o $log_file -t $threads
    ((i=i+1))
done < "$URLs_file"
