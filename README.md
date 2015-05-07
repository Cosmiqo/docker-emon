# Docker emoncms
Dockerized version of [emoncms](https://github.com/emoncms/emoncms).

## Building the images
Run the build script to build cosmiqo/emonbase,cosmiqo/emondata and cosmiqo/emoncms.
```
./build.sh
```

## Running your emoncms image
Start your image and bind ports 80 and 3306 from your container. Pass in a specific password for the emoncms user on the MySQL instance running on the database. Take note of this password as it will have to be the same in future backups and restorations.
```
docker run -d --name emoncms -p 80:80 -p 3306:3306  -e MYSQL_PASSWORD="mypass" cosmiqo/emoncms
```

To tail the logs run ```docker logs -f emoncms```. Visit [http://localhost](http://localhost) to access your deployment of emoncms. If you are using boot2docker, replace localhost with the boot2docker ip. 

## Backup 
The backup script will create a tarball of all the data directories for emoncms. This can be set to run as a part of a cron job to regularly backup the data in the emoncms deployment.
```
./backup.sh NAME_OF_CONTAINER
```
