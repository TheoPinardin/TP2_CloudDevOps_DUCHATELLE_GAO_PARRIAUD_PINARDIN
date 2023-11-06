data "archive_file" "empty_zip_code_lambda" {
  type        = "zip"
  output_path = "empty_lambda_code.zip"
  source {
    content  = "hello_world"
    filename = "dummy.txt"
  }
}

# resource aws_lambda_function s3_to_sqs_lambda


# resource aws_lambda_permission allow_bucket


# resource aws_lambda_function sqs_to_dynamo_lambda


# resource aws_lambda_permission allow_sqs_queue


# resource aws_lambda_function job_api_lambda



# resource aws_lambda_permission allow_api_gw

