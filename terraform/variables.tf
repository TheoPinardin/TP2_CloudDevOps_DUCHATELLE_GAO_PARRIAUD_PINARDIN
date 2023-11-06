# ------------------  utils  ---------------------------
variable "region" {
  default = "eu-west-1"
}

# ------------------  S3  ---------------------------
variable "s3_user_bucket_name" {
  description = "Name of the bucket"
  type        = string
}



# ------------------  SQS  ---------------------------
variable "sqs_job_queue_name" {
  description = "Name of the SQS queue"
  type        = string
}

variable "sqs_job_dead_letter_queue_name" {
  description = "Name of the SQS dead letter queue"
  type        = string
}



# ------------------  DynamoDB  ---------------------------
variable "dynamo_job_table_name" {
  description = "Name of the DynamoDB Table"
  type        = string
}



# ------------------ Lambda ---------------------------
variable "s3_to_sqs_lambda_name" {
  description = "Name of the lambda that retrieves data from S3 and sent it to SQS"
  type        = string
}

variable "sqs_to_dynamo_lambda_name" {
  description = "Name of the lambda that retrieves data from SQS and store it to DynamoDB"
  type        = string
}

variable "job_api_lambda_name" {
  description = "Name of the job api lambda"
  type        = string
}



# ------------------ IAM ---------------------------
variable "s3_to_sqs_lambda_role_name" {
  description = "Name of the the role attached to the s3_to_sqs lambda"
  type        = string
}

variable "sqs_to_dynamo_lambda_role_name" {
  description = "Name of the the role attached to the sqs_to_dynamo lambda"
  type        = string
}

variable "job_api_lambda_role_name" {
  description = "Name of the the role attached to the job_api lambda"
  type        = string
}

variable "lambda_exec_policy_arn" {
  description = "Arn of the AWSLambdaBasicExecutionRole policy"
  type        = string
}


# ------------------ API Gateway ---------------------------
variable "api_gw_name" {
  description = "Name of the the API Gateway of the Job API"
  type        = string
}

variable "api_gw_stage_name" {
  description = "Name of the the stage of the API Gateway"
  type        = string
}
