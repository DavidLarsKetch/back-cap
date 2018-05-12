#!/bin/bash
echo -e "\ngenerateData started with $1 as sid\n"

sid=$1
startDate=$2
endDate=$3
file="data/data.json"
if [[ ! -r "$file" ]];
then
	touch $file
fi

makeStamp() {
	result="0"
	until [[ "$result" > "$startDate" && "$result" < "$endDate" ]]
	do
		H=$(( RANDOM % 22 + 1 ))
		M=$(( RANDOM % 58 + 1 ))
		S=$(( RANDOM % 57 + 1 ))
		result=$(date -d "${startDate:0:10}"T""$H":"$M":"$S" $(( RANDOM % 7)) days" +"%Y-%m-%dT%H:%M:%S")
	done
	echo $result
}

reps=$(( RANDOM % 50 + 50 ))

for ((i=0;i<$reps;i++))
do
	temp=$(( RANDOM % 60 + 40 ))
	stamp=$(makeStamp)

	json="{
		\"Item\":{
			\"Reading\": \"$temp\",
			\"Timestamp\": \"$stamp\",
			\"ScheduleId\": \"$sid\"
		}
	}"
	curl -f -X POST -H "Content-Type: application/json" -d "$json" https://bpo0hlxopi.execute-api.us-east-1.amazonaws.com/dev//data
	
	if [ $? -ne 22 ];
	then
		echo -e $json >> $file
	else
		echo "Failed curl request"
	fi
done
