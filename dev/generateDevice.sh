#!/bin/bash
echo -e "\nGenerateDevice started with $1 as uid\n"
uid=$1
file="data/device.json"
if [ ! -r "$file" ];
then
	touch $file
fi

# Generates 4 devices & their schedules
for ((i=0;i<4;i++)) 
do
	did=d$RANDOM$RANDOM
	json="{
		\"Item\":{
			\"UserId\": \"$uid\",
			\"DeviceId\": \"$did\"
		}
	}"
	
	curl -fs -X POST -d "$json" --header "Content-Type: application/json" https://bpo0hlxopi.execute-api.us-east-1.amazonaws.com/dev//device
	
	if [ $? -eq 22 ];
	then
		echo "Failed curl request"
		exit
	else
		echo -e $json >> $file
		/bin/bash ./generateSchedule.sh "$did"
	fi
done
