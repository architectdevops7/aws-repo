resource "aws_codebuild_project" "example" {
  name = var.project_name

  source {
    type            = var.source_type
    location        = var.source_location
    git_clone_depth = 1
  }

  artifacts {
    type            = var.artifact_type
    location        = var.artifact_location
    name            = var.artifact_name
    namespace_type  = var.artifact_namespace_type
    packaging       = var.artifact_packaging
    override_artifact_name = var.override_artifact_name
    encryption_disabled   = var.artifact_encryption_disabled
  }

  environment {
    compute_type = var.compute_type
    image        = var.image
    type         = var.environment_type

    environment_variable {
      name  = "VAR1"
      value = var.var1
    }

    privileged_mode = var.privileged_mode
  }

  service_role = var.service_role_arn

  build_timeout = var.build_timeout

  cache {
    type     = var.cache_type
    location = var.cache_location
  }

  logs_config {
    cloudwatch_logs {
      group_name = "/aws/codebuild/${var.project_name}"
      stream_name = "{build-{timestamp}"
    }
  }

  buildspec = file(var.buildspec_path)
}

