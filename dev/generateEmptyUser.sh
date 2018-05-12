#!/bin/bash
echo -e "generating empty user started\n"

file="$(dirname $0)/data/user.json"
if [ ! -r "$file" ];
then
	touch $file
fi

#Generaets $reps users or 10 users and their devices
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
		file="$(dirname $0)/data/device.json"
                if [ ! -r "$file" ];
                then
                	touch $file
		fi
		echo -e "Created device $did\n"
		echo -e $json >> $file
	else
		echo "Failed curl request"
	fi

else
	echo "Failed curl request"
	exit
fi
