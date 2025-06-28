resource "aws_iam_role" "pre_signup_trigger" {
  name = "${var.user_pool_name}-pre-signup-trigger-role-${var.environment}"

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

resource "aws_iam_role_policy" "pre_signup_trigger_policy" {
  name = "${var.user_pool_name}-pre-signup-trigger-policy-${var.environment}"
  role = aws_iam_role.pre_signup_trigger.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "cognito-idp:AdminCreateUser",
          "cognito-idp:AdminUpdateUserAttributes",
          "cognito-idp:AdminGetUser"
        ]
        Resource = "*"
      }
    ]
  })
}
