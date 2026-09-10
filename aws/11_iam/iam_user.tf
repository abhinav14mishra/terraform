resource "aws_iam_user" "iam_user" {
  for_each = toset(local.yaml_file.users[*].username)
  name     = each.value
}


resource "aws_iam_user_policy_attachment" "user_policy_attachment" {
  for_each = local.user_policy_arns

  user       = aws_iam_user.iam_user[each.value.username].name
  policy_arn = each.value.policy_arn
}
resource "aws_iam_user_login_profile" "login_profile" {
  for_each        = aws_iam_user.iam_user
  user            = each.value.name
  password_length = 8

  lifecycle {
    ignore_changes = [password_length, pgp_key, password_reset_required]
  }
}