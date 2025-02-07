# Solution

## System Requirements:

1. bash
2. docker
3. docker-compose

## Required scripts/artefacts:

1. mysql_restore.sh
2. docker-compose.yml
3. backups directory with backups in `host[n]_fulldump_[date +"%Y%m%d_%H%M%S"].sql.gz` format

## Usage:

1. Clone the git repository

       git clone https://github.com/kunalsnehi0710/goodgame-mysql-challenge.git

2. Go to the root path

       cd goodgame-mysql-challenge

3. Script Usage:  `. ./mysql_restore.sh [1|2|3] [start|stop]`

   Run the following bash script to start the mysql containers

       . ./mysql_restore.sh 3 start

  (to run only 1 or 2 mysql hosts, pass the number of hosts as 1 or 2)

   To tier down everything with one command
     
         . ./mysql_restore.sh 3 stop

## Connect to mysql database in docker-containers:

1. Execute the `docker ps` command to view the running containers

2. Connect to the running container of your choice using following command

host1:

       docker exec -it host1-mysql-1
host2:
   
       docker exec -it host2-mysql-1
host3:

       docker exec -it host3-mysql-1

4. Once logged in to the container, run the following mysql command to connect to the database

       mysql -u root -p

   When prompted for password, supply the below password,

   Password:
   
       root

6. Database Connected.

7. Execute the SQL queries of your choice

## Assumptions:

1. The naming convention of the backup files in the `backups/` directory remains constant.


