# resource aws_s3_bucket s3_job_offer_bucket
resource "aws_s3_bucket" "s3_job_offer_bucket" {
  bucket = var.s3_user_bucket_name
}


# resource aws_s3_object job_offers


resource "aws_s3_bucket_object" "job_offers" {
  bucket = aws_s3_bucket.s3_job_offer_bucket.id
  key    = "job_offers/"
}
# resource aws_s3_bucket_notification bucket_notification

