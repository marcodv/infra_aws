environment                    = "dev"
type_resource                  = "destroyable"
availability_zones             = ["eu-west-1a", "eu-west-1b"] //, "eu-west-1c"]
bastions-ami                   = "ami-04dd4500af104442f"

// The next vars are related to eks, node-group, launch config 
namespaces = [
  {
    manage             = "Terraform",
    name               = "staging"
    custom_annotations = [{ label = "staging.io/annotation", value = "staging" }]
    custom_labels      = [{ label = "environment", value = "staging" }]
  },
  {
    manage             = "Terraform",
    name               = "development"
    custom_annotations = [{ label = "development.io/annotation", value = "development" }]
    custom_labels      = [{ label = "environment", value = "development" }]
  },
  {
    manage             = "Terraform",
    name               = "production"
    custom_annotations = [{ label = "production.io/annotation", value = "production" }]
    custom_labels      = [{ label = "environment", value = "production" }]
  },
  {
    manage             = "Terraform",
    name               = "monitoring"
    custom_annotations = [{ label = "service.io/annotation", value = "monitoring" }]
    custom_labels      = [{ label = "service", value = "monitoring" }]
  }
]

cluster_admin_permissions = [
  {
    api_groups = [""]
    resources  = ["nodes", "namespaces", "pods"]
    verbs      = ["get", "list", "watch", "describe"]
  },
  {
    api_groups = ["apps"]
    resources  = ["deployments", "daemonsets", "replicasets", "statefulsets"]
    verbs      = ["get", "list", "watch", "describe"]
  },
  {
    api_groups = ["batch"]
    resources  = ["cronjobs", "jobs"]
    verbs      = ["get", "list", "watch", "describe"]
  }
]

read_only_user_permissions = [
  {
    api_groups = [""]
    resources  = ["*"]
    verbs      = ["get", "list", "watch", "describe"]
  },
  {
    api_groups = ["apps"]
    resources  = ["*"]
    verbs      = ["get", "list", "watch", "describe"]
  },
  {
    api_groups = ["batch"]
    resources  = ["*"]
    verbs      = ["get", "list", "watch", "describe"]
  },
  {
    api_groups = ["extensions"]
    resources  = ["*"]
    verbs      = ["get", "list", "watch", "describe"]
  }
]

read_only_eks_users = {
  users = [
    {
      userarn  = "arn:aws:iam::848481299679:user/Lens_User_dev_Env"
      username = "Lens_User_dev_Env@noah.energy"
      groups   = ["cluster-read-only-group"]
    }
  ]
}

map_cluster_admin_users = {
  admins = [
    {
      userarn  = "arn:aws:iam::848481299679:user/bastiaan@noah.energy"
      username = "bastiaan@noah.energy"
      groups   = ["system:masters", "cluster-full-admin-group"]
    },
    {
      userarn  = "arn:aws:iam::848481299679:user/marco@noah.energy"
      username = "marco@noah.energy"
      groups   = ["system:masters", "cluster-full-admin-group"]
    },
    {
      userarn  = "arn:aws:iam::848481299679:user/Terraform_User_Dev_Env"
      username = "Terraform_User_Dev_Env@noah.energy"
      groups   = ["system:masters", "cluster-full-admin-group"]
    }
  ]
}

workers_nodes_instance_type = ["t2.medium"]

worker_nodes_scaling_config = {
  desired_size = 2
  max_size     = 4
  min_size     = 1
}

worker_nodes_update_config = {
  max_unavailable = 1
}

eks_version = 1.21

// EKS ALB ingress controller definition
eks_ingress_controller_port_path = {
  ingress_port     = 30080
  healt_check_path = "/"
}

worker_node_role = "arn:aws:iam::848481299679:role/WorkerNodeRoledevEnv"

eks_logs_type = ["api",  "controllerManager", "scheduler"]

zone_id = "Z01432692YENOFU1EN1BH"