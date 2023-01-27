module "permission_sets" {
  source = "./modules/permission-sets"

  permission_sets = [
    {
      name               = "Engg-PowerUser",
      description        = "Allow Poweruser Access to the account for Engineering",
      relay_state        = "",
      session_duration   = "",
      tags               = {},
      inline_policy      = "",
      policy_attachments = ["arn:aws:iam::aws:policy/PowerUserAccess"]
      customer_managed_policy_attachments = []
    },
    {
      name                                = "Engg-ReadOnly",
      description                         = "Allow ReadOnly access to the account for Engineering",
      relay_state                         = "",
      session_duration                    = "",
      tags                                = {},
      inline_policy                       = "",
      policy_attachments                  = ["arn:aws:iam::aws:policy/job-function/ViewOnlyAccess"]
      customer_managed_policy_attachments = []
    }
  ]
}

module "sso_account_assignments" {
  source = "./modules/account-assignments"

  account_assignments = [
    {
      account             = "116309360350", # Represents the "production" account
      permission_set_arn  = module.permission_sets.permission_sets["Engg-PowerUser"].arn,
      permission_set_name = "Engg-PowerUser",
      principal_type      = "GROUP",
      principal_name      = "Developers"
    },
    {
      account             = "262169116715", # Represents the "Sandbox" account
      permission_set_arn  = module.permission_sets.permission_sets["Engg-PowerUser"].arn,
      permission_set_name = "Engg-PowerUser",
      principal_type      = "GROUP",
      principal_name      = "Developers"
    },
    {
      account             = "116309360350",
      permission_set_arn  = module.permission_sets.permission_sets["Engg-ReadOnly"].arn,
      permission_set_name = "Engg-ReadOnly",
      principal_type      = "GROUP",
      principal_name      = "Testers"
    },
    {
      account             = "262169116715", # Represents the "Sandbox" account
      permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-65958a9bd17fab05/ps-23bdfb80e564879e",
      permission_set_name = "AWSReadOnlyAccess", #Adding an existing PermissionSet
      principal_type      = "GROUP",
      principal_name      = "Testers"
    },
    {
      account             = "116309360350", # Represents the "production" account
      permission_set_arn  = "arn:aws:sso:::permissionSet/ssoins-65958a9bd17fab05/ps-281aae2cfbe9b144",
      permission_set_name = "Engg-PowerUser",
      principal_type      = "GROUP",
      principal_name      = "Developers"
    }
  ]
}
