// Cluster role FULL ACCESS to dashboard
resource "kubernetes_cluster_role" "eks-dashboard-access-clusterrole" {
  depends_on = [ kubernetes_namespace.namespaces ]
  metadata {
    name      = "eks-console-dashboard-full-access-clusterrole"
  }

  rule {
    api_groups = [""]
    resources  = ["nodes", "namespaces", "pods"]
    verbs      = ["get", "list", "watch", "describe"]
  }

  rule {
    api_groups = ["apps"]
    resources  = ["deployments", "daemonsets", "replicasets", "statefulsets"]
    verbs      = ["get", "list", "watch", "describe"]
  }

  rule {
    api_groups = ["batch"]
    resources  = ["cronjobs", "jobs"]
    verbs      = ["get", "list", "watch", "describe"]
  }

}

// Cluster role binding FULL ACCESS to dashboard
resource "kubernetes_cluster_role_binding" "eks-dashboard-access-clusterrole-binding" {
  depends_on = [ kubernetes_namespace.namespaces ]
  metadata {
    name      = "eks-dashboard-access-clusterrole-binding"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.eks-dashboard-access-clusterrole.metadata[0].name
  }

  subject {
    kind      = "Group"
    name      = "eks-console-dashboard-full-access-group"
    api_group = "rbac.authorization.k8s.io"
  }
}

// Cluster role LIMITED ACCESS to dashboard
resource "kubernetes_cluster_role" "eks-dashboard-limited-access-clusterrole" {
  depends_on = [ kubernetes_namespace.namespaces ]
  metadata {
    name      = "eks-dashboard-limited-access-clusterrole"
  }

  rule {
    api_groups = [""]
    resources  = ["nodes", "namespaces"]
    verbs      = ["get", "list"]
  }

  rule {
    api_groups = ["apps"]
    resources  = ["deployments", "daemonsets", "replicasets", "statefulsets"]
    verbs      = ["get", "list"]
  }

  rule {
    api_groups = ["batch"]
    resources  = ["jobs"]
    verbs      = ["get", "list"]
  }

}

// Cluster role binding FULL ACCESS to dashboard
resource "kubernetes_cluster_role_binding" "eks-dashboard-limited-access-clusterrole-binding" {
  depends_on = [ kubernetes_namespace.namespaces ]
  metadata {
    name      = "eks-dashboard-limited-access-clusterrole-binding"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.eks-dashboard-limited-access-clusterrole.metadata[0].name
  }

  subject {
    kind      = "Group"
    name      = "eks-dashboard-limited-access-clusterrole"
    api_group = "rbac.authorization.k8s.io"
  }
}

// Role for LIMITED ACCESS to dashboard
resource "kubernetes_role" "eks-dashboard-limited-access-roles" {
  depends_on = [ kubernetes_namespace.namespaces ]

  for_each = { for k, v in var.namespaces: k => v}
  metadata {
    name = "eks-dashboard-limited-access-role"
    namespace = each.value.name
  }

    rule {
    api_groups = [""]
    resources  = ["pods", "namespaces"]
    verbs      = ["get", "list"]
  }

  rule {
    api_groups = ["apps"]
    resources  = ["deployments", "daemonsets", "replicasets", "statefulsets"]
    verbs      = ["get", "list"]
  }

  rule {
    api_groups = ["batch"]
    resources  = ["jobs"]
    verbs      = ["get", "list"]
  }
}