# aws-website-api-lambda

# Code
The entire stack is packaged in the terraform module "aws-website-api-lambda".

## lambda/
This folder contains the lambda function code
Each subfolder in this folder has lambda function code files for the specific function

## main.tf
Example file for how to use the module

# Deployment
To deploy an instance of the whole stack, instantiate the module in the project root as follows.
Tags are optional, but can be used to separate different environments and perform auditing, accounting, etc.
Prefix is mandatory and helps in distinguishing different instances of the deployed stack. Each resource name has this prefix string in the name, and helps distinguish resources visually very easily.
```
module "website-module-instance" {
  source = "./aws-website-api-lambda"
  prefix = "akokje"
  tags = {
    "Environment" = "production",
    "Type" = "sales"
  }
}

output "website_api_base_url" {
  value = module.test-website.base_url
}
```

When the stack is deployed using ```terraform apply```, the output will tell you which URL to use to access the API.
With the prefix name strategy, you will notice that even the API will have the prefix name.

## Testing
For deployment in test environment, assign tag "Environment" as "testing".
If you have several developers deploying and testing in the same AWS account, then use assign "prefix" as the developer account name e.g. "akokje"
Additionally, you can use complex naming conventions as required.

## Production
For deployment in test environment, assign tag "Environment" as "production".
You may use more tags and prefix convention for specific use cases.
