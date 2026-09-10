locals {
  yaml_file = yamldecode(file("${path.module}/user.yaml"))
  policy_arns = {
    readonly  = "arn:aws:iam::aws:policy/ReadOnlyAccess"
    developer = "arn:aws:iam::aws:policy/PowerUserAccess"
    admin     = "arn:aws:iam::aws:policy/AdministratorAccess"
    auditor   = "arn:aws:iam::aws:policy/SecurityAudit"
  }
  user_policy_arns = {
    for item in flatten([
      for user in local.yaml_file.users : [
        for policy in user.policies : {
          username   = user.username
          policy_arn = local.policy_arns[policy]
        }
      ]
    ]) : "${item.username}-${item.policy_arn}" => item
  }
}
