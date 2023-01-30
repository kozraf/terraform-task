data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}


resource "aws_iam_user" "prod-ci-user" {
  name = "prod-ci-user"

 tags = {
    Name = "${var.name_prefix}-user"
  }
}

resource "aws_iam_access_key" "prod-ci-user_access_key" {
  user = aws_iam_user.prod-ci-user.name
}

resource "aws_iam_group" "prod-ci-group" {
  name = "prod-ci-group"
}

resource "aws_iam_group_membership" "prod-ci-group-membership" {
  name = "prod-ci-group-membership"

  users = [
    aws_iam_user.prod-ci-user.name
  ]

  group = aws_iam_group.prod-ci-group.name
}

resource "aws_iam_policy" "prod-ci-policy" {
  name        = "prod-ci-policy"
  description = "prod-ci-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
        ]
        Effect   = "Allow"
        Resource = "arn:aws:iam::${data.aws_caller_identity.current.id}:role/prod-ci-role"
      },
    ]
  })

  tags = {
    Name = "${var.name_prefix}-policy"
  }

}

resource "aws_iam_role" "prod-ci-role" {
  name = "prod-ci-role"
  description = "prod-ci-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.id}:root"
        }
      },
    ]
  })

  tags = {
    Name = "${var.name_prefix}-role"
  }
}

resource "aws_iam_policy_attachment" "prod-ci-IAM-attach" {
  name       = "prod-ci-IAM-attach"
  groups     = [aws_iam_group.prod-ci-group.name]
  policy_arn = aws_iam_policy.prod-ci-policy.arn
}