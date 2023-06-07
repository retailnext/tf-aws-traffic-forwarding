variable "environment_name" {
  type = string
}

variable "name" {
  type = string
}

variable "role_policy_attachment_arns" {
  default     = []
  description = "ARNs of additional managed policies to attach to the role."
  type        = set(string)
}

variable "role_policy_documents" {
  default     = {}
  description = "Additional IAM policy documents to attach to the role."
  type        = map(string)
}

variable "workspace_name" {
  type    = string
  default = ""
}
