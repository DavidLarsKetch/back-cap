#!/bin/bash
while getopts d:r: opt; do
	case $opt in
		d) did=$OPTARG;;
		r) reps=$([[ "$OPTARG" -gt 0 ]] && echo "$OPTARG" || echo 2 )

	esac
done

echo -e "\ngenerateSchedule started with $did as did\n"

types=(beer kombucha tempeh yogurt koji wine whiskey cheese vodka sake)

file="$(dirname $0)/data/schedule.json"
if [ ! -r "$file" ];
then
	touch $file
fi

for ((i=0;i<$reps;i++));
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

	curl -fs -X POST -H "Content-Type: application/json" -d "$json" https://bpo0hlxopi.execute-api.us-east-1.amazonaws.com/dev//schedule > /dev/null
	
	if [ $? -ne 22 ];
	then
		echo -e "Created schedule $sid\n"
		echo -e $json >> $file
		/bin/bash ./generateData.sh -s $sid -b $startDate -e $endDate -r 0
	else
		echo "Failed curl request"
	fi
done
