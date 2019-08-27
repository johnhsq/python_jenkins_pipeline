#!/bin/bash

# set variables
hostname='localhost'
port=$1

# wait for the app to start
sleep 20 

# ping the app
status_code=$(curl --write-out %{response_code} --out /dev/null --silent ${hostname}:${port})

if [ $status_code == 200 ];
then
	echo "PASS: ${hostname}:${port} is reachable"
else
	echo $status_code
	echo "FAIL: ${hostname}:${port} is unreachable"
    exit 1
fi
