provider "aws" {
  profile = "default"
}

terraform {
  required_version = "~> 0.13.0"

  backend "s3" {
    bucket = "shimpeiws-ecs-deployment-code-deploy"
    key    = "dev/terraform.tfstate"
  }
}

module "code-pipeline" {
  source                     = "../modules/code-pipeline"
  env_name                   = "dev"
  code_build_project_name    = "ecs-deployment-code-deploy"
  code_pipeline_project_name = "ecs-deployment-code-deploy"
  github_project_url         = "https://github.com/shimpeiws/ecs-deployment-code-deploy"
  github_account_name        = "shimpeiws"
  github_oauth_token         = var.github_oauth_token
  github_repo_name           = "ecs-deployment-code-deploy"
  github_branch_name         = "master"
  plan_buildspec_path        = "./code-build/terraform-plan-build-spec.yml"
  apply_buildspec_path       = "./code-build/terraform-apply-build-spec.yml"
  need_approval              = true
}
