#! /bin/bash
# 
# wait for a specific user to log in, check every 30 seconds

printf "Enter username: "
read user
until who | grep "$user" > /dev/null
do
	sleep 10
done
