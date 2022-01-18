// Default role for developer
resource "kubernetes_role" "namespace-viewer" {
  metadata {
    name      = "developer-viewer"
    namespace = "default"
  }

  rule {
    api_groups = [""]
    resources  = ["pods", "pods/logs", "pods/attach", "pods/exec", "services", "serviceaccounts", "configmaps", "persistentvolumes", "persistentvolumeclaims", "secrets"]
    verbs      = ["get", "list", "watch", "describe"]
  }

  rule {
    api_groups = ["apps"]
    resources  = ["deployments", "daemonsets", "statefulsets"]
    verbs      = ["get", "list", "watch", "describe"]
  }

  rule {
    api_groups = ["batch"]
    resources  = ["cronjobs", "jobs"]
    verbs      = ["get", "list", "watch", "describe"]
  }
}

// Role for access to EKS dashboard
resource "kubernetes_role" "eks-dashboard-access-clusterrole" {
  metadata {
    name      = "eks-console-dashboard-full-access-clusterrole"
    namespace = "default"
  }

  rule {
    api_groups = [""]
    resources  = ["nodes", "namespaces", "pods"]
    verbs      = ["get", "list"]
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

// Role Binding for developer viewer
resource "kubernetes_role_binding" "namespace-viewer" {
  metadata {
    name      = "developer-viewer"
    namespace = "default"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = kubernetes_role.namespace-viewer.metadata[0].name
  }
  subject {
    kind      = "User"
    name      = "developer"
    api_group = "rbac.authorization.k8s.io"
  }
}

// Role Binding for access to EKS dashboard
resource "kubernetes_role_binding" "eks-dashboard-access-binding" {
  metadata {
    name      = "eks-console-dashboard-full-access-binding"
    namespace = "default"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_role.eks-dashboard-access-clusterrole.metadata[0].name
  }

  subject {
    kind      = "Group"
    name      = "eks-console-dashboard-full-access-group"
    api_group = "rbac.authorization.k8s.io"
  }

}
