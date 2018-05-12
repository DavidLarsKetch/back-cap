#!/bin/bash
while getopts r: opt; do
	case $opt in
		r) reps=$([[ "$OPTARG" -gt 0 ]] && echo "$OPTARG" || echo 10 )

	esac
done

echo -e "generateUser started\n"

file="$(dirname $0)/data/user.json"
if [ ! -r "$file" ];
then
	touch $file
fi

#Generaets $reps users or 10 users and their devices
for ((i=0;i<$reps;i++));
do
	uid=u$RANDOM$RANDOM
	json="{
		\"Item\": {
			\"UserId\": \"$uid\"
		}
	}"
	
	curl -fs -X POST -H "Content-Type: application/json" -d "$json" https://bpo0hlxopi.execute-api.us-east-1.amazonaws.com/dev//user > /dev/null
	
	if [ $? -ne 22 ];
	then
		echo -e "Created user $uid\n"
		echo -e $json >> $file 
		/bin/bash ./generateDevice.sh -u "$uid" -r 0
	else
		echo "Failed curl request"
		exit
	fi
done
