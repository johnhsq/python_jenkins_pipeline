#!/bin/bash

# set variables
#hostname='localhost'
# when Jenkins is in a container while the testing App is in another container, 
# the "curl" in Jenkins container can't access the test app
# here's the workaround: https://docs.docker.com/docker-for-mac/networking/#use-cases-and-workarounds
hostname='host.docker.internal'
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
	curl ${hostname}:${port}
    exit 1
fi
