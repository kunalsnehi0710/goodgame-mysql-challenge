#! /bin/bash

display_usage() { 
	echo -e "\n This script must be run with two arguments: num_of_hosts and state (start/stop)." 
	echo -e "\n Usage: . ./mysql_restore.sh [ 1 start ] / [ 1 stop ] / [ 2 start ] \n" 
	} 

# if less than two arguments supplied, display usage 
	if [  $# -le 1 ] 
	then 
		display_usage
	fi 

# check whether user had supplied -h or --help . If yes display usage 
	if [[ ( $@ == "--help") ||  $@ == "-h" ]] 
	then 
		display_usage
	fi 

# variables to accept user args
hosts=$1
state=$2
port=3306

# To start the mysql instances
if [ $state == "start" ]; then
for (( i = 1; i <= $hosts; i++)); do
    snap="host$i"_fulldump_"`ls backups/host$i* | awk -F "_fulldump_" '{print$2}' | awk -F "." '{print$1}' | sort -n | tail -1`.sql"
    echo "HOST=host$i" > mysql.env
    mkdir -p restores
    gunzip -c backups/$snap.gz > restores/$snap
    echo "SNAP=$snap" >> mysql.env
    port=$((port + 1))
    echo "PORT=$port" >> mysql.env
    docker-compose -p host$i --env-file mysql.env up -d
done
fi

# To destroy and cleanup mysql instances/volumes
if [ $state == "stop" ]; then
for (( i = 1; i <= $hosts; i++)); do
    snap="host$i"_fulldump_"`ls backups/host$i* | awk -F "_fulldump_" '{print$2}' | awk -F "." '{print$1}' | sort -n | tail -1`.sql"
    echo "HOST=host$i" > mysql.env
    echo "SNAP=$snap" >> mysql.env
    docker-compose -p host$i --env-file mysql.env down
    rm -f restores/$snap
    docker volume prune -f
done
fi
