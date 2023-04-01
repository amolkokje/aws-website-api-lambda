
# -------------------
# API
# -------------------

# Permission to for API gateway to execute Lambda function

resource "aws_lambda_permission" "api_gw" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.website_api_lambda_function.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "${aws_apigatewayv2_api.website_lambda_api.execution_arn}/*/*"
}
