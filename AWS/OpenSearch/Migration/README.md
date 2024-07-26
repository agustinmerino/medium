# Steps to Export and Import an Index from Elastic Cloud or AWS OpenSearch

  

## Use Cases:

  

### 1. Export an Index from Elastic Cloud:

  

#### a. Setup your variables:

  

-  `HOST`: Elastic Cloud host

-  `PORT`: Elastic Cloud Port

-  `SOURCE_INDEX`: Elastic Cloud's index name

-  `USER`: Elastic Cloud username

-  `PASSWORD`: Elastic Cloud user password

  

#### b. Executing shell file:

  

```sh

chmod  a+x  export-import.sh

./export-elastic-cloud.sh $HOST $PORT $SOURCE_INDEX $USER $PASSWORD
```
  
  
  

### 2. Export an Index from AWS OpenSearch:

  

#### a. Setup your variables:

  

-  `SOURCE_INDEX`:  OpenSearch's index name

- `OPENSEARCH_DOMAIN`: OpenSearch domain endpoint

- `AWS_ACCESS_KEY_ID`: Your AWS Access Key ID

- `AWS_SECRET_ACCESS_KEY`: Your AWS Secret Access Key

- `AWS_SESSION_TOKEN`: Your AWS Session Token

  

#### b. Executing shell file:

  

```sh

chmod a+x export-import.sh

./export-opensearch.sh $SOURCE_INDEX $OPENSEARCH_DOMAIN $AWS_ACCESS_KEY_ID $AWS_SECRET_ACCESS_KEY $AWS_SESSION_TOKEN
```
  
  
  

### 3. Import an Index to Elastic Cloud:

  

#### a. Setup your variables:

  

- `HOST`: Elastic Cloud host

- `PORT`: Elastic Cloud Port

- `TARGET_INDEX`: Elastic Cloud's  index  name

-  `USER`:  Elastic  Cloud  username

-  `PASSWORD`:  Elastic  Cloud  user  password

  

#### b. Executing shell file:

  

```sh

chmod a+x export-import.sh

./import-elastic-cloud.sh $HOST $PORT $TARGET_INDEX $USER $PASSWORD
```
  
  

### 4. Import an Index to AWS OpenSearch:

  

#### a. Setup your variables:

  

- `TARGET_INDEX`: OpenSearch's index name

- `OPENSEARCH_DOMAIN`: OpenSearch domain endpoint

- `AWS_ACCESS_KEY_ID`: Your AWS Access Key ID

- `AWS_SECRET_ACCESS_KEY`: Your AWS Secret Access Key

- `AWS_SESSION_TOKEN`: Your AWS Session Token

  

#### b. Executing shell file:

  

```sh

chmod a+x export-import.sh

./import-opensearch.sh $TARGET_INDEX $OPENSEARCH_DOMAIN $AWS_ACCESS_KEY_ID $AWS_SECRET_ACCESS_KEY $AWS_SESSION_TOKEN
```