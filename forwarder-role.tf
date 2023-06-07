module "forwarder-role" {
  source = "./modules/forwarder-role"

  environment_name = local.environment_name
  name             = "forwarder"

  role_policy_attachment_arns = [
    "arn:aws:iam::00000000000:policy/InstanceBaseline",
  ]
}
