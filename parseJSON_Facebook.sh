#!/bin/bash

# Import file
file=$1
number=$2

# Count number of objects in file
length=`jq '.messages | length' $file`

# Loop through each object in file
for (( i=0; i<$length; i++ ))
do
    name=`cat $file | jq --argjson index ${i} '.messages[$index] .sender_name'` 
    text=`cat $file | jq --argjson index ${i} '.messages[$index] .content'`
    time=`cat $file | jq --argjson index ${i} '.messages[$index] .timestamp_ms'`

    echo -e "${name}\t${text}\t${time}" >> FacebookMessages${number}.txt

done
