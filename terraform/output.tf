# output base_url
output "base_url" {
  description = "Base URL for API Gateway stage."
  value       = aws_apigatewayv2_stage.job_api_gw_dev_stage.invoke_url
}
