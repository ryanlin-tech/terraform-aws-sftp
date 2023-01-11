data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

#IAM role for the GPG decryption lambda function
resource "aws_iam_role" "lambda_execution_role" {
  name               = "lambda-lambdaRole-waf"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}

data "archive_file" "python_lambda_package" {
  type        = "zip"
  source_file = "${path.module}/decryption-function.py"
  output_path = "gpg-decryption-lambda.zip"
}

resource "aws_lambda_function" "decryption_lambda_function" {
  description      = "Function responsible for performing GPG decryption process."
  function_name    = "gpg-decryption-lambda"
  filename         = "gpg-decryption-lambda.zip"
  source_code_hash = data.archive_file.python_lambda_package.output_base64sha256
  runtime          = "python3.8"
  memory_size      = 256
  timeout          = 20
  layers           = ["arn:aws:lambda:ap-southeast-2:359968734520:layer:python-gnupg:1"]
  role             = aws_iam_role.lambda_execution_role.arn
  handler          = "index.lambda_handler"
}
