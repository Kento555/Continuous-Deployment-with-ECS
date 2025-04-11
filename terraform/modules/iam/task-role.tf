resource "aws_iam_role" "custom_task_role" {
  name = "${var.env}-ecs-task-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = { Service = "ecs-tasks.amazonaws.com" },
      Action = "sts:AssumeRole"
    }]
  })

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [name, tags]
  }
}

resource "aws_iam_policy" "task_custom_policy" {
  name = "${var.env}-ecs-task-policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Action = [
        "s3:*",
        "dynamodb:*"
      ],
      Resource = "*"
    }]
  })

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [name]
  }
}

resource "aws_iam_role_policy_attachment" "task_role_policy_attach" {
  role       = aws_iam_role.custom_task_role.name
  policy_arn = aws_iam_policy.task_custom_policy.arn
}
