#!/bin/bash

# Import file
file=$1

# Count number of objects in file
length=`jq '. | length' $file`

# Loop through each object in file
for (( i=0; i<$length; i++ ))
do
    name=`cat $file | jq --argjson index ${i} '.[$index] .name'`
    text=`cat $file | jq --argjson index ${i} '.[$index] .text'`
    time=`cat $file | jq --argjson index ${i} '.[$index] .created_at'`

    echo -e "${name}\t${text}\t${time}" >> GroupMeMessages.txt
done
