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


SOURCE_INDEX=$1
OPENSEARCH_DOMAIN=$2
AWS_ACCESS_KEY_ID=$3
AWS_SECRET_ACCESS_KEY=$4
AWS_SESSION_TOKEN=$5


# Export Index settings $SOURCE_INDEX
 
echo " ----- Starting $SOURCE_INDEX Export from $HOST to /opt/data/export_settings.json file  ----- "
sudo docker run --rm -ti -v /opt/data:/opt/data elasticdump/elasticsearch-dump \
  --input=$OPENSEARCH_DOMAIN/$SOURCE_INDEX \
  --output=/opt/data/export_settings.json \
  --type=settings \
  --awsAccessKeyId $AWS_ACCESS_KEY_ID \
  --awsSecretAccessKey $AWS_SECRET_ACCESS_KEY \
  --sessionToken $AWS_SESSION_TOKEN
echo " ----- Completed $SOURCE_INDEX Export from $HOST to /opt/data/export_settings.json file  ----- "
 
# Export Index Mapping $SOURCE_INDEX
echo " ----- Starting $SOURCE_INDEX Export from $HOST to /opt/data/export_mapping.json file  ----- "
sudo docker run --rm -ti -v /opt/data:/opt/data elasticdump/elasticsearch-dump \
  --input=$OPENSEARCH_DOMAIN/$SOURCE_INDEX \
  --output=/opt/data/export_mapping.json \
  --type=mapping \
  --awsAccessKeyId $AWS_ACCESS_KEY_ID \
  --awsSecretAccessKey $AWS_SECRET_ACCESS_KEY \
  --sessionToken $AWS_SESSION_TOKEN
echo " ----- Completed $SOURCE_INDEX Export from $HOST to /opt/data/export_mapping.json file  ----- "
 
# Export Index data $SOURCE_INDEX
echo " ----- Starting $SOURCE_INDEX Export from $HOST to /opt/data/export.json file  ----- "
sudo docker run --rm -ti -v /opt/data:/opt/data elasticdump/elasticsearch-dump \
  --input=$OPENSEARCH_DOMAIN/$SOURCE_INDEX \
  --output=/opt/data/export.json \
  --type=data \
  --awsAccessKeyId $AWS_ACCESS_KEY_ID \
  --awsSecretAccessKey $AWS_SECRET_ACCESS_KEY \
  --sessionToken $AWS_SESSION_TOKEN
echo " ----- Completed $SOURCE_INDEX Export from $HOST to /opt/data/export.json file  ----- "
 