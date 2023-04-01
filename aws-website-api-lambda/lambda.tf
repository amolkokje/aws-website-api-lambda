# Lambda function execution role

resource "aws_iam_role" "website_lambda_execution_role" {
  name = join("-", [var.prefix, "website-lambda-execution-role"])

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })

  tags = var.tags
}

# Lambda function

resource "aws_lambda_function" "website_api_lambda_function" {
  filename         = "${data.archive_file.website_lambda_function_zip.output_path}"
  function_name    = join("-", [var.prefix, "website-lambda-function"])
  role             = aws_iam_role.website_lambda_execution_role.arn
  handler          = "website_lambda_function.lambda_handler"
  runtime          = "python3.8"
  memory_size      = 128
  timeout          = 30
  source_code_hash = data.archive_file.website_lambda_function_zip.output_base64sha256

  tags = var.tags

}
