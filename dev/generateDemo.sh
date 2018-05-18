#!/bin/bash
uid=$1
did=$2
file="$(dirname $0)/data/demo.json"
# Generate random ScheudleId
sid=s$RANDOM$RANDOM

# Sine wave properties & loop counter
rate=1000
i=1

if [ ! -r $file ]; then
	touch $file
fi

errorCheck() {
	if [ $1 -eq 22 ];
	then
		echo -e "Failed curl request for $2\n"
		exit
	fi
}

echo -e "Welcome to the stuk demo\n"

#Make device if not provided
if [[ -z "$did" ]];
then
	did=d$RANDOM$RANDOM
	json="{
		\"Item\":{
			\"UserId\": \"$uid\",
			\"DeviceId\": \"$did\"
		}
	}"
		
	curl -fs -X POST -d "$json" --header "Content-Type: application/json" https://bpo0hlxopi.execute-api.us-east-1.amazonaws.com/dev//device
	
	errorCheck $? "device"
	
	echo -e "\nCreated device $did\n"
	echo -e "$json" >> $file
fi

# Make schedule
# For schedule's target range & generating temps on a
json="{
	\"Item\":{
		\"ScheduleId\": \"$sid\",
		\"DeviceId\": \"$did\"
	}
}"

curl -fs -X POST -H "Content-Type: application/json" -d "$json" https://bpo0hlxopi.execute-api.us-east-1.amazonaws.com/dev//schedule

errorCheck $? "schedule"

echo -e "\nCreated schedule $sid\n"
echo -e "$json" >> "$file"

# Make data in a sine wave


calcTemp() {
# Calculates a freq of approx. 2
	freq=$(awk -v seed="$RANDOM" -v i="$i" 'BEGIN{srand(seed);print rand() / i + 2}')

	amp=$(awk -v r="$rate" -v f="$freq" -v i="$i" 'BEGIN{print sin(2*atan2(0,-1)*(f*(i/r)))}')
	temp=$(echo "$amp * 10 + (60 + (100 - 60) / 2)" | bc)

	echo $temp
}

postData() {
	temp=$(calcTemp)
	thisDate=$(date +"%Y-%m-%dT%H:%M:%S") 
	json="{
		\"Item\":{
			\"Reading\": \"$temp\",
			\"Timestamp\": \"$thisDate\",
			\"ScheduleId\": \"$sid\"
		}
	}"

	curl -fs -X POST -H "Content-Type: application/json" -d "$json" https://bpo0hlxopi.execute-api.us-east-1.amazonaws.com/dev//data

	errorCheck $? "data"

	echo -e "\nCreated data point $temp"
	echo "$json" >> "$file"

	if [[ "$i" -ge $rate ]];
	then
		i=1
	else
		((i++))
	fi
	
	sleep 2
	postData
}

postData
