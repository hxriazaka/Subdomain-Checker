#!/bin/bash

# ASCII art logo
echo "
               __         __                     _     
   _______  __/ /_  ____/ /___  ____ ___  ____ _(_)___ 
  / ___/ / / / __ \/ __  / __ \/ __ `__ \/ __ `/ / __ \
 (__  ) /_/ / /_/ / /_/ / /_/ / / / / / / /_/ / / / / /
/____/\__,_/_.___/\__,_/\____/_/ /_/ /_/\__,_/_/_/ /_/ 
                                                       
        __              __            
  _____/ /_  ___  _____/ /_____  _____
 / ___/ __ \/ _ \/ ___/ //_/ _ \/ ___/
/ /__/ / / /  __/ /__/  < /  __/ /    
\___/_/ /_/\___/\___/_/|_|\___/_/     By riazaka
"

# Input file with subdomains
input_file="subdomain_exmple.txt"

# Output file for alive subdomains
output_file="alive_subdomains_exmple.txt"

# Temporary file for filtered subdomains
temp_file="temp.txt"

# Filter out subdomains with invalid characters
grep -E "^[a-zA-Z0-9.-]+$" $input_file > $temp_file

# Check the status code of each filtered subdomain
while read subdomain; do
  status_code=$(curl -s -o /dev/null -w "%{http_code}" $subdomain)
  if [ $status_code -eq 200 ]; then
    echo "$subdomain ====> Alive"
    echo $subdomain >> $output_file
  else
    echo "$subdomain ====> Not Alive"
  fi
done < $temp_file

# Remove the temporary file
rm $temp_file

# Print the number of alive subdomains
count=$(wc -l < $output_file)
echo "Found $count alive subdomains"
