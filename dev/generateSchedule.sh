#!/bin/bash
echo -e "\ngenerateSchedule started with $1 as did\n"

did=$1
types=(beer kombucha tempeh yogurt koji wine whiskey cheese vodka sake)
file="data/schedule.json"

if [ ! -r "$file" ];
then
	touch $file
fi

for ((i=0;i<2;i++));
do
	sid=s$RANDOM$RANDOM
	m=$(( RANDOM % 11 + 1 ))
	d=$(( RANDOM % 27 + 1 ))
	H=$(( RANDOM % 22 + 1 ))
	M=$(( RANDOM % 58 + 1 ))
	S=$(( RANDOM % 57 + 1 ))
	startDate=$(date -d "2018-"$m"-"$d"T"$H":"$M":"$S"" +"%Y-%m-%dT%H:%M:%S")
	endDate=$(date -d "$startDate 7 days" +"%Y-%m-%dT%H:%M:%S")
	typeToPost=${types[${RANDOM:0:1}]}
	json="{
		\"Item\":{
			\"FermentType\": \"$typeToPost\",
			\"StartDate\": \"$startDate\",
			\"EndDate\": \"$endDate\",
			\"ScheduleId\": \"$sid\",
			\"DeviceId\": \"$did\"
		}
	}"

	curl -f -X POST -H "Content-Type: application/json" -d "$json" https://bpo0hlxopi.execute-api.us-east-1.amazonaws.com/dev//schedule
	
	if [ $? -ne 22 ];
	then
		echo -e $json >> $file
		/bin/bash ./generateData.sh $sid $startDate $endDate
	else
		echo "Failed curl request"
	fi
done
