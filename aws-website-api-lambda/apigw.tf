# ------------------------
# API
# ------------------------

resource "aws_apigatewayv2_api" "website_lambda_api" {
  name          = join("-", [var.prefix, "website-lambda-api"])
  protocol_type = "HTTP"

  tags = var.tags
}

# lambda
resource "aws_apigatewayv2_stage" "website_lambda_api_stage" {
  api_id = aws_apigatewayv2_api.website_lambda_api.id

  name        = join("-", [var.prefix, "website-lambda-api-stage"])
  auto_deploy = true

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.website_lambda_api_route_log_group.arn

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
      }
    )
  }

  tags = var.tags
}

# ------------------------
# API Integration methods
# ------------------------

# Lambda integration
resource "aws_apigatewayv2_integration" "website_lambda_api_integration" {
  api_id = aws_apigatewayv2_api.website_lambda_api.id

  integration_uri    = aws_lambda_function.website_api_lambda_function.invoke_arn
  integration_type   = "AWS_PROXY"
  integration_method = "POST"
}

# ------------------------
# API routes
# ------------------------

# GET /
resource "aws_apigatewayv2_route" "website_lambda_api_route" {
  api_id = aws_apigatewayv2_api.website_lambda_api.id

  route_key = "GET /"
  target    = "integrations/${aws_apigatewayv2_integration.website_lambda_api_integration.id}"
}
