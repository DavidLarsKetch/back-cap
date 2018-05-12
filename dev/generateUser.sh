#!/bin/bash

file="data/user.json"
echo -e "generateUser started\n"
if [ ! -r "$file" ];
then
	touch $file
fi

#Generaes 10 users and their devices
for ((i=0;i<10;i++));
do
	uid=u$RANDOM$RANDOM
	json="{
		\"Item\": {
			\"UserId\": \"$uid\"
		}
	}"
	
	curl -fs -X POST -H "Content-Type: application/json" -d "$json" https://bpo0hlxopi.execute-api.us-east-1.amazonaws.com/dev//user
	
	if [ $? -ne 22 ];
	then
		echo -e $json >> $file 
		/bin/bash ./generateDevice.sh "$uid"
	else
		echo "Failed curl request"
		exit
	fi
done
