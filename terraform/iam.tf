# resource aws_iam_role iam_for_s3_to_sqs_lambda
resource "aws_iam_role" "s3_to_sqs_lambda_role" {
  name = var.s3_to_sqs_lambda_name
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "lambda.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })
}


# resource aws_iam_role_policy lambda_logging_for_s3_to_sqs

resource "aws_iam_role_policy" "s3_to_sqs_lambda_policy" {
  name = "s3_to_sqs_lambda_policy"
  role = aws_iam_role.s3_to_sqs_lambda_role.id

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": "s3:*",
        "Resource": "${aws_s3_bucket.s3_job_offer_bucket.arn}/*"
      }
    ]
  })
}

#resource "aws_iam_role_policy" "lambda_logging_for_s3_to_sqs" {
#  name   = "lambda_logging_for_s3_to_sqs"
#  role   = aws_iam_role.iam_for_s3_to_sqs_lambda.id
#  policy = file("files/log_policy.json")
#}

# resource aws_iam_role_policy iam_policy_for_sqs_sender

resource "aws_iam_role_policy" "s3_to_sqs_lambda_send_message_policy" {
  name = "s3_to_sqs_lambda_send_message_policy"
  role = aws_iam_role.s3_to_sqs_lambda_role.id

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": "sqs:SendMessage",
        "Resource": aws_sqs_queue.job_offers_queue.arn
      }
    ]
  })
}

# resource aws_iam_role_policy iam_policy_for_s3

resource "aws_iam_role_policy" "iam_policy_for_s3_full_access" {
  name        = "iam-policy-for-s3-full-access"
  role        = aws_iam_role.s3_to_sqs_lambda_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "s3:*",
        Effect = "Allow",
        Resource = "*",
      },
    ],
  })
}


# resource aws_iam_role iam_for_sqs_to_dynamo_lambda

resource "aws_iam_role" "sqs_to_dynamo_lambda_role" {
  name = var.sqs_to_dynamo_lambda_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}


# resource aws_iam_role_policy lambda_logging_for_sqs_to_dynamo
#resource "aws_iam_role_policy" "lambda_logging_for_sqs_to_dynamo" {
#  name   = "lambda_logging_for_sqs_to_dynamo"
#  role   = aws_iam_role.iam_for_sqs_to_dynamo_lambda.id
#  policy = file("files/log_policy.json")
#}

# resource aws_iam_role_policy iam_policy_for_dynamodb
resource "aws_iam_policy" "iam_policy_for_dynamodb" {
  name        = "dynamodb_policy"
  description = "Policy to allow DynamoDB action"
  
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "dynamodb:PutItem",
        Effect = "Allow",
        Resource = aws_dynamodb_table.job-table.arn
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "dynamodb_policy_attachment" {
  name = "dynamodb_policy_attachment"  
  policy_arn = aws_iam_policy.iam_policy_for_dynamodb.arn
  roles      = [aws_iam_role.sqs_to_dynamo_lambda_role.name]
}

# resource aws_iam_role_policy iam_policy_for_sqs_receiver
resource "aws_iam_policy" "iam_policy_for_sqs_receiver" {
  name        = "sqs_to_dynamo_policy"
  description = "Policy to allow SQS actions"
  
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes",
        ],
        Effect = "Allow",
        Resource = aws_sqs_queue.job_offers_queue.arn
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "sqs_policy_attachment" {
  name = "sqs_policy_attachment"  
  policy_arn = aws_iam_policy.iam_policy_for_sqs_receiver.arn
  roles      = [aws_iam_role.sqs_to_dynamo_lambda_role.name]
}

# resource aws_iam_role iam_for_job_api_lambda


resource "aws_iam_role" "job_api_lambda_role" {
  name = var.job_api_lambda_role_name 
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}





# resource aws_iam_role_policy iam_policy_for_dynamodb

resource "aws_iam_policy" "job_api_lambda_policy" {
  name        = "job_api_lambda_policy"
  description = "Policy for the Job API Lambda"
  
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "dynamodb:*",
        Effect = "Allow",
        Resource = aws_dynamodb_table.job-table.arn
      }
    ]
  })
}



# resource aws_iam_role_policy lambda_logging_for_job_api
#resource "aws_iam_role_policy" "lambda_logging_for_job_api" {
#  name   = "lambda_logging_for_job_api"
#  role   = aws_iam_role.iam_for_job_api_lambda.id
#  policy = file("files/log_policy.json")
#}

# resource aws_iam_role_policy_attachment lambda_exec_policy_attach

resource "aws_iam_role_policy_attachment" "lambda_exec_policy_attach" {
  policy_arn = aws_iam_policy.job_api_lambda_policy.arn
  role       = aws_iam_role.job_api_lambda_role.name
}