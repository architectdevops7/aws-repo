resource "aws_codedeploy_app" "lambda_app" {
  name = var.app_name
}

resource "aws_codedeploy_deployment_group" "lambda_deployment_group" {
  name                  = var.deployment_group_name
  deployment_config_name = var.deployment_config_name
  app_name              = aws_codedeploy_app.lambda_app.name

  auto_rollback_configuration {
    enabled = var.auto_rollback_enabled
    events  = var.auto_rollback_events
  }

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"
  }

  blue_green_deployment_config {
    deployment_ready_option {
      action_on_timeout = "CONTINUE_DEPLOYMENT"
    }
  }

  ec2_tag_set {
    ec2_tag_set_list {
      key   = "Name"
      value = var.ec2_tag_value
    }
  }

  trigger_configuration {
    trigger_name            = "lambda-deployment"
    trigger_target_arn      = aws_lambda_function.lambda_function.arn
    trigger_events          = ["DeploymentStart", "DeploymentSuccess", "DeploymentFailure"]
    trigger_target_attribute = "All"
  }
}

resource "aws_codedeploy_deployment_config" "lambda_deployment_config" {
  deployment_config_name = var.deployment_config_name

  minimum_healthy_hosts {
    type             = "HOST_COUNT"
    value            = var.minimum_healthy_hosts
    additional_options {
      percentage_limited = var.minimum_healthy_hosts_percentage_limited
    }
  }

  traffic_routing_config {
    type               = "TimeBasedCanary"
    time_based_canary {
      canary_percentage       = var.canary_percentage
      canary_interval         = var.canary_interval
      traffic_routing_method  = var.traffic_routing_method
      wait_time_in_minutes    = var.wait_time_in_minutes
      stability_threshold     = var.stability_threshold
    }
  }
}

resource "aws_lambda_function" "lambda_function" {
  function_name = var.lambda_function_name
  role          = aws_iam_role.lambda_codedeploy_role.arn
  runtime       = var.runtime
  handler       = var.handler
  filename      = var.object_key

  source_code_hash = filebase64sha256(var.object_key)

  environment {
    variables = var.environment_variables
  }

  tags = var.tags
}

resource "aws_iam_role" "lambda_codedeploy_role" {
  name = "lambda-codedeploy-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "codedeploy.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_codedeploy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRoleForLambda"
  role       = aws_iam_role.lambda_codedeploy_role.name
}

