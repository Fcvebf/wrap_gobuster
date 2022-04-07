# wrap_gobuster

A simple wrapper scipt in case you need to scan a bunch of web applications. Can be customized to your preferred tool (ffuf,dirb etc)

Wrapper script for gobuster<br/>

Syntax: wrap_gobuster.sh -u URLs_file  -w wordlist [ -t threads | -d results_folder | -h ]<br/>

-u     the file with the target URLs<br/>
-w     the wordlist<br/>
-t     the threads<br/>
-d     the directory where to write the results<br/>
-h     print the help<br/>
