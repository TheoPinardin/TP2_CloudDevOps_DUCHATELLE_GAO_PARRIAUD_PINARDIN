# resource aws_apigatewayv2_api job_api_gw
resource "aws_apigatewayv2_api" "job_api_gw" {
  name          = var.api_gw_name  
  protocol_type = "HTTP"
}




# resource aws_apigatewayv2_stage job_api_gw_dev_stage


resource "aws_apigatewayv2_stage" "job_api_gw_dev_stage" {
  name          = var.api_gw_stage_name
  api_id        = aws_apigatewayv2_api.job_api_gw.id
  auto_deploy   = true

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_gw.arn


    format = jsonencode({
      requestId               = "$context.requestId"
      sourceIp                = "$context.identity.sourceIp"
      requestTime             = "$context.requestTime"
      protocol                = "$context.protocol"
      httpMethod              = "$context.httpMethod"
      resourcePath            = "$context.resourcePath"
      routeKey                = "$context.routeKey"
      status                  = "$context.status"
      responseLength          = "$context.responseLength"
      integrationErrorMessage = "$context.integrationErrorMessage"
    })
  }
}


# resource aws_apigatewayv2_integration job_api_gw_integration

output "job_api_gw_dev_stage_invoke_url" {
  value = aws_apigatewayv2_stage.job_api_gw_dev_stage.invoke_url
}

# resource aws_apigatewayv2_route job_api_gw_route


resource "aws_cloudwatch_log_group" "api_gw" {
  name              = "/aws/api_gw/${aws_apigatewayv2_api.job_api_gw.name}"
  retention_in_days = 5
}


