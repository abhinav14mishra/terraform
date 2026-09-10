# output "yaml_file" {
#   value = local.yaml_file
# }

# Username and ARN output
output "iam_usernames_arns" {
  value = { for user in aws_iam_user.iam_user : user.name => user.arn }
}

#BadPractice: outputting passwords in plaintext is not recommended. Use sensitive = true to hide the output.
output "passwords" {
  value     = { for user, profile in aws_iam_user_login_profile.login_profile : user => profile.password }
  sensitive = true
}