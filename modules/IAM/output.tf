output "IAM_username" {
  value = {
    IAM_username  = aws_iam_user.prod-ci-user.name
  }
}

output "IAM_group" {
  value = {
    IAM_group  = aws_iam_group.prod-ci-group.name
  }
}

output "IAM_role" {
  value = {
    IAM_role  = aws_iam_role.prod-ci-role.name
  }
}

output "IAM_group_policy" {
  value = {
    IAM_group_policy  = aws_iam_policy.prod-ci-policy.name
  }
}