# resource aws_dynamodb_table job-table

resource "aws_dynamodb_table" "job-table" {
  name           = var.dynamo_job_table_name
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key = "id"
  range_key = "city"

  attribute {
    name = "id"
    type = "S"
  }

  attribute {
    name = "city"
    type = "S"
  }

  
}


