output "ecs_cluster_name" {
  value = module.ecs.cluster_name
}

output "task_role_arn" {
  value = module.iam_task_role.task_role_arn
}
