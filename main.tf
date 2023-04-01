
module "test-website" {
  source = "./aws-website-api-lambda"
  prefix = "test-amolkokje"
  tags = {
    "Environment" = "production",
    "Type" = "akokje"
  }
}

output "website_api_base_url" {
  value = module.test-website.base_url
}
