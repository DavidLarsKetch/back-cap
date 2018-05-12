#!/bin/bash
while getopts u:r: opt; do
	case $opt in
		u) uid=$OPTARG;;
		r) reps=$([[ "$OPTARG" -gt 0 ]] && echo "$OPTARG" || echo 4 )

	esac
done

echo -e "\nGenerateDevice started with $uid as uid\n"

file="$(dirname $0)/data/device.json"
if [ ! -r "$file" ];
then
	touch $file
fi

# Generates $reps devices or 4 if not specified
for ((i=0;i<$reps;i++)) 
do
	did=d$RANDOM$RANDOM
	json="{
		\"Item\":{
			\"UserId\": \"$uid\",
			\"DeviceId\": \"$did\"
		}
	}"
	
	curl -fs -X POST -d "$json" --header "Content-Type: application/json" https://bpo0hlxopi.execute-api.us-east-1.amazonaws.com/dev//device > /dev/null
	if [ $? -ne 22 ];
	then
		echo -e "Created device $did\n"
		echo -e $json >> $file
		/bin/bash ./generateSchedule.sh -d "$did" -r 0
	else
		echo "Failed curl request"
		exit
	fi
done
