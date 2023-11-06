# Create dynamo table
export AWS_ACCESS_KEY_ID=dynamo
export AWS_SECRET_ACCESS_KEY=dynamo123
export AWS_DEFAULT_REGION=localhost
aws --endpoint-url http://localhost:8003 dynamodb create-table --table-name job-table \
 --attribute-definitions AttributeName=id,AttributeType=S AttributeName=city,AttributeType=S \
 --key-schema AttributeName=id,KeyType=HASH AttributeName=city,KeyType=RANGE \
 --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5
