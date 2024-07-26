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

TARGET_INDEX=$1
OPENSEARCH_DOMAIN=$2
AWS_ACCESS_KEY_ID=$3
AWS_SECRET_ACCESS_KEY=$4
AWS_SESSION_TOKEN=$5

 
# Import Index  settings $TARGET_INDEX
 
echo " ----- Starting $TARGET_INDEX Import from /opt/data/export_settings.json file  to $OPENSEARCH_DOMAIN ----- "
sudo docker run --rm -ti -v /opt/data:/opt/data elasticdump/elasticsearch-dump \
  --input="/opt/data/export_settings.json" \
  --output=$OPENSEARCH_DOMAIN/$TARGET_INDEX \
  --type=settings \
  --awsAccessKeyId $AWS_ACCESS_KEY_ID \
  --awsSecretAccessKey $AWS_SECRET_ACCESS_KEY \
  --sessionToken $AWS_SESSION_TOKEN
echo " ----- Completed $TARGET_INDEX Import from /opt/data/export_settings.json file  to $OPENSEARCH_DOMAIN ----- "
 
 
# Import Index mapping $TARGET_INDEX
 
echo " ----- Starting $TARGET_INDEX Import from /opt/data/export_mapping.json file  to $OPENSEARCH_DOMAIN ----- "
sudo docker run --rm -ti -v /opt/data:/opt/data elasticdump/elasticsearch-dump \
  --input="/opt/data/export_mapping.json" \
  --output=$OPENSEARCH_DOMAIN/$TARGET_INDEX \
  --type=mapping \
  --awsAccessKeyId $AWS_ACCESS_KEY_ID \
  --awsSecretAccessKey $AWS_SECRET_ACCESS_KEY \
  --sessionToken $AWS_SESSION_TOKEN
echo " ----- Completed $TARGET_INDEX Import from /opt/data/export_mapping.json file  to $OPENSEARCH_DOMAIN ----- "
 
# Import Index data $TARGET_INDEX

echo " ----- Starting $TARGET_INDEX Import from /opt/data/export.json file  to $OPENSEARCH_DOMAIN ----- "
sudo docker run --rm -ti -v /opt/data:/opt/data elasticdump/elasticsearch-dump \
  --bulk=true \
  --input="/opt/data/export.json" \
  --output=$OPENSEARCH_DOMAIN \
  --type=data \
  --awsAccessKeyId $AWS_ACCESS_KEY_ID \
  --awsSecretAccessKey $AWS_SECRET_ACCESS_KEY \
  --sessionToken $AWS_SESSION_TOKEN
echo " ----- Completed $TARGET_INDEX Import from /opt/data/export.json file  to $OPENSEARCH_DOMAIN ----- "