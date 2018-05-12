#!/bin/bash
while getopts s:b:e:r: opt; do
	case $opt in
		s) sid=$OPTARG;;
		b) startDate=$( date -d "$OPTARG" +"%Y-%m-%dT%H:%M:S");;
		e) endDate=$( date -d "$OPTARG" +"%Y-%m-%dT%H:%M:S");;
		r) reps=$([[ "$OPTARG" -gt 0 ]] && echo "$OPTARG" || echo $(( RANDOM % 50 + 50 )) )
	esac
done
echo -e "\ngenerateData started with $sid as sid\n"

file="$(dirname $0)/data/data.json"
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

for ((i=0;i<$reps;i++))
do
	temp=$(( RANDOM % 60 + 40 ))
	thisDate=$(makeStamp)
	json="{
		\"Item\":{
			\"Reading\": \"$temp\",
			\"Timestamp\": \"$thisDate\",
			\"ScheduleId\": \"$sid\"
		}
	}"
	curl -fs -X POST -H "Content-Type: application/json" -d "$json" https://bpo0hlxopi.execute-api.us-east-1.amazonaws.com/dev//data > /dev/null
	
	if [ $? -ne 22 ];
	then
		echo -e "Created reading of $temp for schedule $sid\n"
		echo -e $json >> $file
	else
		echo "Failed curl request"
	fi
done
