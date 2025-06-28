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
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "main" {
  function_name = var.function_name
  handler       = var.handler
  runtime       = "provided.al2"
  role          = aws_iam_role.lambda_role.arn

  filename         = var.filename
  source_code_hash = filebase64sha256(var.filename)

  timeout     = var.timeout
  memory_size = var.memory_size
}

