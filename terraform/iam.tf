# resource aws_iam_role iam_for_s3_to_sqs_lambda


# resource aws_iam_role_policy lambda_logging_for_s3_to_sqs
#resource "aws_iam_role_policy" "lambda_logging_for_s3_to_sqs" {
#  name   = "lambda_logging_for_s3_to_sqs"
#  role   = aws_iam_role.iam_for_s3_to_sqs_lambda.id
#  policy = file("files/log_policy.json")
#}

# resource aws_iam_role_policy iam_policy_for_sqs_sender


# resource aws_iam_role_policy iam_policy_for_s3


# resource aws_iam_role iam_for_sqs_to_dynamo_lambda


# resource aws_iam_role_policy lambda_logging_for_sqs_to_dynamo
#resource "aws_iam_role_policy" "lambda_logging_for_sqs_to_dynamo" {
#  name   = "lambda_logging_for_sqs_to_dynamo"
#  role   = aws_iam_role.iam_for_sqs_to_dynamo_lambda.id
#  policy = file("files/log_policy.json")
#}

# resource aws_iam_role_policy iam_policy_for_dynamodb


# resource aws_iam_role_policy iam_policy_for_sqs_receiver


# resource aws_iam_role iam_for_job_api_lambda


# resource aws_iam_role_policy iam_policy_for_dynamodb


# resource aws_iam_role_policy lambda_logging_for_job_api
#resource "aws_iam_role_policy" "lambda_logging_for_job_api" {
#  name   = "lambda_logging_for_job_api"
#  role   = aws_iam_role.iam_for_job_api_lambda.id
#  policy = file("files/log_policy.json")
#}

# resource aws_iam_role_policy_attachment lambda_exec_policy_attach

