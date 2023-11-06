# Lambda
s3_to_sqs_lambda_name     = "s3_to_sqs_lambda"
sqs_to_dynamo_lambda_name = "sqs_to_dynamo_lambda"
job_api_lambda_name       = "job_api_lambda"

# S3
s3_user_bucket_name = "job-offers-bucket-tp-esme-serverless-backend"

# SQS
sqs_job_queue_name             = "job-offers-queue"
sqs_job_dead_letter_queue_name = "job-offers-deadletter-queue"

# DynamoDB
dynamo_job_table_name = "job-offers"


# IAM
s3_to_sqs_lambda_role_name     = "s3_to_sqs_lambda_role"
sqs_to_dynamo_lambda_role_name = "sqs_to_dynamo_lambda_role"
job_api_lambda_role_name       = "job_api_lambda_role"
lambda_exec_policy_arn         = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"


# API Gateway
api_gw_name       = "job_api_gw"
api_gw_stage_name = "dev"
