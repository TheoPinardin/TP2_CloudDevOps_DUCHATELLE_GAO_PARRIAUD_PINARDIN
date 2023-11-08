data "archive_file" "empty_zip_code_lambda" {
  type        = "zip"
  output_path = "empty_lambda_code.zip"
  source {
    content  = "hello_world"
    filename = "dummy.txt"
  }
}

# resource aws_lambda_function s3_to_sqs_lambda

resource "aws_lambda_function" "s3_to_sqs_lambda" {
  filename      = data.archive_file.empty_zip_code_lambda.output_path
  function_name = "s3_to_sqs_lambda"
  role          = aws_iam_role.s3_to_sqs_lambda_role.arn
  handler       = "index.handler"
  memory_size   = 512
  timeout       = 900
  runtime       = "nodejs18.x"

  environment {
    variables = {
      QUEUE_URL = aws_sqs_queue.job_offers_queue.url
    }
  }


  }


resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.s3_job_offer_bucket.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.s3_to_sqs_lambda.arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "job_offers/"
    filter_suffix       = ".csv"

           
  }

}
# resource aws_lambda_permission allow_bucket
resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action       = "lambda:InvokeFunction"
  function_name = aws_lambda_function.s3_to_sqs_lambda.function_name
  principal    = "s3.amazonaws.com"
  source_arn   = aws_s3_bucket.s3_job_offer_bucket.arn
}


# resource aws_lambda_function sqs_to_dynamo_lambda


# resource aws_lambda_permission allow_sqs_queue


# resource aws_lambda_function job_api_lambda



# resource aws_lambda_permission allow_api_gw

