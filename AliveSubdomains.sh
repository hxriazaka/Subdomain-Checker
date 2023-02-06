#!/bin/bash

# Put file with subdomains
subs_file="exmple.txt"

# Put file for alive subdomains
alive_subs_file="exmple.txt"

# Temporary file for filtered subdomains
temp_file="temp.txt"

# Filter out subdomains with invalid characters
grep -E "^[a-zA-Z0-9.-]+$" $subs_file > $temp_file

# Check the status code of each filtered subdomain
while read subdomain; do
  status_code=$(curl -s -o /dev/null -w "%{http_code}" $subdomain)
  if [ $status_code -eq 200 ]; then
    echo $subdomain >> $alive_subs_file
  fi
done < $temp_file

# Remove the temporary file
rm $temp_file

# Print the number of alive subdomains that we found
count=$(wc -l < $alive_subs_file)
echo "Found $count alive subdomains"
