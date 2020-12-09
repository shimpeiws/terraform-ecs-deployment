variable "env_name" {
  description = "Environment name"
  type        = string
}

variable "code_build_project_name" {
  description = "CodeBuild Project name"
  type        = string
}

variable "code_pipeline_project_name" {
  description = "CodePipeline Project name"
  type        = string
}

variable "github_project_url" {
  description = "GitHub project URL"
  type        = string
}

variable "github_account_name" {
  description = "GitHub account name or organization name"
  type        = string
}

variable "github_oauth_token" {
  description = "GitHub oauth token"
  type        = string
}

variable "github_repo_name" {
  description = "GitHub repository name"
  type        = string
}

variable "github_branch_name" {
  description = "GitHub branch name"
  type        = string
}

variable "plan_buildspec_path" {
  description = "Path for build spec that is used for terraform plan"
  type        = string
}

variable "apply_buildspec_path" {
  description = "Path for build spec that is used for terraform apply"
  type        = string
}

variable "need_approval" {
  description = "Approval step is required od not"
  type        = bool
}
