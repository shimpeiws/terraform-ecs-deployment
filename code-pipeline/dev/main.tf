provider "aws" {
  profile = "default"
}

terraform {
  required_version = "~> 0.13.0"

  backend "s3" {
    bucket = "shimpeiws-code-pipeline-deployment"
    key    = "dev/terraform.tfstate"
  }
}

module "code-pipeline" {
  source                     = "../modules/code-pipeline"
  env_name                   = "dev"
  code_build_project_name    = "code-pipeline-deployment"
  code_pipeline_project_name = "code-pipeline-deployment"
  github_project_url         = "https://github.com/shimpeiws/code-pipeline-deployment"
  github_account_name        = "shimpeiws"
  github_oauth_token         = var.github_oauth_token
  github_repo_name           = "code-pipeline-deployment"
  github_branch_name         = "master"
  plan_buildspec_path        = "./code-build/terraform-plan-build-spec.yml"
  apply_buildspec_path       = "./code-build/terraform-apply-build-spec.yml"
  need_approval              = true
}
