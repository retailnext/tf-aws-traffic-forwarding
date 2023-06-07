locals {
  region           = "us-east-1"
  aws_account_id   = "000000000000"
  environment_name = "vacuum"

  alarm_action_arns = [
    "arn:aws:sns:${local.region}:${local.aws_account_id}:pagerduty-forwarders",
  ]
}
