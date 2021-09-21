resource "aws_iam_role" "role_lambda" {
  name = "roleLambda"

  assume_role_policy = <<-POLICY
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "lambda.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
  }
  POLICY
}

resource "aws_lambda_function" "hello_world_terraform_tomi" {
  function_name = "lambda_function_hello_world_terraform_tomi"
  role          = aws_iam_role.role_lambda.arn
  handler       = "example.Handler::handleRequest"
  filename      = "blank-java-1.0-SNAPSHOT.jar"
  timeout       = 60
  runtime       = "java8"
  memory_size   = 1024
  environment {
    variables = {
      ENV_MAX_WIDTH  = "200",
      ENV_MAX_HEIGHT = "200"
    }
  }
}
