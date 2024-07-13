# Solution

## System Requirements:

1. bash
2. docker
3. docker-compose

## Required scripts/artefacts:

1. mysql_restore.sh
2. docker-compose.yml
3. backups directory

## Usage:
`. ./mysql_restore.sh [1|2|3] [start|stop]`

1. Run the following bash script to start the mysql containers
   
`. ./mysql_restore.sh 3 start`

(to run only 1 or 2 mysql hosts, pass the number of hosts as 1 or 2)

3. To tier down everything with one command

`. ./mysql_restore.sh 3 stop`

## Connect to mysql docker-containers:

1. Execute the `docker ps` command to view the running containers
2. Connect to the running container of your choice using following command

   `docker exec -it host1-mysql-1` 

(host2-mysql-1 for host2, host3-mysql-1 for host3)
3. Once logged in to the container, run the following mysql command to connect to the database

   `mysql -u root -p`
   When prompted for password, supply the password as `root`
4. Database Connected.
5. Execute the SQL queries of your choice



