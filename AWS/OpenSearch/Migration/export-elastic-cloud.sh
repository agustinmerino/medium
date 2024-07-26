#!bin/bash

# Docker Install
 
service_is_active=$(sudo systemctl is-active docker)
 
  if [ $service_is_active = "active" ]
  then
    echo "Docker is active and running"
  else
    yum update -y
    sudo amazon-linux-extras install docker -y
    sudo service docker start
    sudo systemctl enable docker
    echo "Docker Installed"
  fi

# Environment variables

HOST=$1
PORT=$2
SOURCE_INDEX=$3
USER=$4
PASSWORD=$4



# Export Index settings $SOURCE_INDEX
 
echo " ----- Starting $SOURCE_INDEX Export from $HOST to /opt/data/export_settings.json file  ----- "
sudo docker run --rm -ti -v /opt/data:/opt/data elasticdump/elasticsearch-dump \
  --input=https://$USER:$PASSWORD@$HOST:$PORT/$SOURCE_INDEX \
  --output=/opt/data/export_settings.json \
  --type=settings
echo " ----- Completed $SOURCE_INDEX Export from $HOST to /opt/data/export_settings.json file  ----- "
 
# Export Index Mapping $SOURCE_INDEX
echo " ----- Starting $SOURCE_INDEX Export from $HOST to /opt/data/export_mapping.json file  ----- "
sudo docker run --rm -ti -v /opt/data:/opt/data elasticdump/elasticsearch-dump \
  --input=https://$USER:$PASSWORD@$HOST:$PORT/$SOURCE_INDEX \
  --output=/opt/data/export_mapping.json \
  --type=mapping
echo " ----- Completed $SOURCE_INDEX Export from $HOST to /opt/data/export_mapping.json file  ----- "
 
# Export Index data $SOURCE_INDEX
echo " ----- Starting $SOURCE_INDEX Export from $HOST to /opt/data/export.json file  ----- "
sudo docker run --rm -ti -v /opt/data:/opt/data elasticdump/elasticsearch-dump \
  --input=https://$USER:$PASSWORD@$HOST:$PORT/$SOURCE_INDEX \
  --output=/opt/data/export.json \
  --type=data
echo " ----- Completed $SOURCE_INDEX Export from $HOST to /opt/data/export.json file  ----- "
 
 