#!/bin/bash
temp=${RANDOM: -2}
id=${RANDOM:0:4}
file="data/data.json"

while [ "${temp:0:1}" == 0 ]
do
	temp=${RANDOM:-2}
done
echo $temp

while [ "${id:0:1}" == 0 ]
do
	id=${RANDOM:0:4}
done
echo $id
if [ ! -r "$file" ];
then
	touch $file
fi

json="{
	\"Item\":{
		\"Reading\": \"$temp\",
		\"Timestamp\": \"$(date -Iseconds)\"
	}
}"


curl -fs -X POST -d "$json" --header "Content-Type: application/json" https://bpo0hlxopi.execute-api.us-east-1.amazonaws.com/dev//data?ScheduleId="$id"


if [ $? -ne 22 ];
then
	echo $json && echo -e $json >> $file
else
	echo "Failed curl request"
fi
