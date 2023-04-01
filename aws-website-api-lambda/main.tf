
# Zip the lambda function code files

data "archive_file" "website_lambda_function_zip" {
  type        = "zip"
  source_dir  = "${path.module}/lambda/website_lambda"
  output_path = "${path.module}/website_lambda_function.zip"
}
