# resource aws_sqs_queue job_offers_queue
resource "aws_sqs_queue" "job_offers_queue" {
  name = var.sqs_job_queue_name
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dead_letter_queue.arn
    maxReceiveCount     = 4
  })
}



# resource aws_sqs_queue job_offers_queue_deadletter

resource "aws_sqs_queue" "dead_letter_queue" {
  name = var.sqs_job_dead_letter_queue_name
}

# resource aws_lambda_event_source_mapping sqs_lambda_trigger

resource "aws_lambda_event_source_mapping" "sqs_to_dynamo_mapping" {
  event_source_arn = aws_sqs_queue.job_offers_queue.arn 
  function_name = aws_lambda_function.sqs_to_dynamo_lambda.function_name
}
