# Cloudwatch log group to log API access events
resource "aws_cloudwatch_log_group" "website_lambda_api_route_log_group" {
  name = "/aws/api_gw/${aws_apigatewayv2_api.website_lambda_api.name}"
  retention_in_days = 30

  tags = var.tags
}
