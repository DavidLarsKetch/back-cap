#!/bin/bash
echo -e "Welcome to the stuk demo\n"
if [ ! $1 ]; then
	echo -e "Please supply a uid\n"
	exit
else
	uid=$1
fi

file="$(dirname $0)/data/demo.json"
if [ ! -r $file ]; then
	touch $file
fi

types=(beer kombucha tempeh yogurt koji wine whiskey cheese vodka sake)

errorCheck() {
	if [ $? -eq 22 ];
	then
		echo -e "Failed curl request for $1\n"
		exit
	fi
}

#Make device
did=d$RANDOM$RANDOM
json="{
	\"Item\":{
		\"UserId\": \"$uid\",
		\"DeviceId\": \"$did\"
	}
}"
	
curl -fs -X POST -d "$json" --header "Content-Type: application/json" https://bpo0hlxopi.execute-api.us-east-1.amazonaws.com/dev//device

errorCheck $did

echo -e "\nCreated device $did\n"
echo -e "$json" >> $file

# Make schedule
sid=s$RANDOM$RANDOM
startDate=$(date +"%Y-%m-%dT%H:%M:%S")
endDate=$(date -d "$startDate 7 days" +"%Y-%m-%dT%H:%M:%S")
typeToPost=${types[${RANDOM:0:1}]}

# For schedule's target range & generating temps on a
if [[ "$(( RANDOM % 2 ))" -eq 1 ]];
then
	max=100
	min=80
else
	max=80
	min=60
fi

json="{
	\"Item\":{
		\"FermentType\": \"$typeToPost\",
		\"StartDate\": \"$startDate\",
		\"EndDate\": \"$endDate\",
		\"ScheduleId\": \"$sid\",
		\"DeviceId\": \"$did\",
		\"TargetMax\": \"$max\",
		\"TargetMin\": \"$min\"
	}
}"

curl -fs -X POST -H "Content-Type: application/json" -d "$json" https://bpo0hlxopi.execute-api.us-east-1.amazonaws.com/dev//schedule
errorCheck $sid
echo -e "\nCreated schedule $sid\n"
echo -e "$json" >> "$file"

# Make data in a sine wave

# Sine wave properties & loop counter
rate=1000
i=1

calcTemp() {
# Calculates a freq of approx. 2
	freq=$(awk -v seed="$RANDOM" -v i="$i" 'BEGIN{srand(seed);print rand() / i + 2}')

	amp=$(awk -v r="$rate" -v f="$freq" -v i="$i" 'BEGIN{print sin(2*atan2(0,-1)*(f*(i/r)))}')
	temp=$(echo "$amp * 10 + ($min + ($max - $min) / 2)" | bc)

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
	errorCheck $temp

	echo -e "\n"
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
