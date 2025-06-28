resource "aws_iam_role" "lambda_role" {
  name = "${var.function_name}_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sßts:AssumeRole"
      }
    ]
  })
}

resource "aws_lambda_function" "main" {
  function_name = var.function_name
  handler       = var.handler
  runtime       = "provided.al2"
  role          = aws_iam_role.lambda_role.arn

  filename         = var.filename
  source_code_hash = filebase64sha256(var.filename)
}

