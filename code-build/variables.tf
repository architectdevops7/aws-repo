variable "project_name" {
  description = "Name of the CodeBuild project"
}

variable "source_type" {
  description = "Type of source for the CodeBuild project"
  default     = "GITHUB"
}

variable "source_location" {
  description = "Location of the source for the CodeBuild project"
}

variable "compute_type" {
  description = "Compute type for the CodeBuild project"
  default     = "BUILD_GENERAL1_SMALL"
}

variable "buildspec_path" {
  description = "Path to the buildspec file for the CodeBuild project"
  default     = "buildspec.yml"
}

variable "service_role_arn" {
  description = "ARN of the IAM service role for the CodeBuild project"
}

variable "build_timeout" {
  description = "Timeout in minutes for the CodeBuild project"
  default     = 60
}

variable "cache_type" {
  description = "Type of cache for the CodeBuild project"
  default     = "S3"
}

variable "cache_location" {
  description = "Location of the cache for the CodeBuild project"
}

variable "artifact_type" {
  description = "Type of artifact for the CodeBuild project"
  default     = "S3"
}

variable "artifact_location" {
  description = "Location of the artifact for the CodeBuild project"
}

variable "artifact_name" {
  description = "Name of the artifact for the CodeBuild project"
  default     = "app"
}

variable "artifact_namespace_type" {
  description = "Namespace type of the artifact for the CodeBuild project"
  default     = "BUILD_ID"
}

variable "artifact_packaging" {
  description = "Packaging type of the artifact for the CodeBuild project"
  default     = "ZIP"
}

variable "override_artifact_name" {
  description = "Overrides the artifact name if set"
}

variable "artifact_encryption_disabled" {
  description = "Whether artifact encryption is disabled or not"
  default     = false
}

variable "image" {
  description = "The Docker image to use for the build environment"
  default     = "aws/codebuild/amazonlinux2-x86_64-standard:
}

variable "environment_type" {
  description = "Type of environment for the CodeBuild project"
  default     = "LINUX_CONTAINER"
}

variable "var1" {
  description = "An environment variable to pass to the build environment"
}

variable "privileged_mode" {
  description = "Whether or not to run the build in privileged mode"
  default     = false
}

