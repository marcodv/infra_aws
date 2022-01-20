// Cluster FULL ACCESS role
resource "kubernetes_cluster_role" "cluster_full_admin_role" {
  depends_on = [kubernetes_namespace.namespaces]

  metadata {
    name = "cluster-full-admin-role"
  }

  dynamic "rule" {
    for_each = var.cluster_admin_permissions
    content {
      api_groups = rule.value.api_groups
      resources  = rule.value.resources
      verbs      = rule.value.verbs
    }
  }
}

// Cluster FULL ACCESS role binding
resource "kubernetes_cluster_role_binding" "cluster_full_admin_role_binding" {
  depends_on = [kubernetes_namespace.namespaces]
  metadata {
    name = "cluster-full-admin-role-binding"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-full-admin-role"
  }

  subject {
    kind      = "Group"
    name      = "cluster-full-admin-group"
    api_group = "rbac.authorization.k8s.io"
  }
}

// Read Only Role
resource "kubernetes_role" "cluster_role_read_only" {
  depends_on = [kubernetes_namespace.namespaces]

  for_each = { for k, v in var.namespaces : k => v }
  metadata {
    name      = "cluster-read-only-role"
    namespace = each.value.name
  }

  dynamic "rule" {
    for_each = var.read_only_user_permissions
    content {
      api_groups = rule.value.api_groups
      resources  = rule.value.resources
      verbs      = rule.value.verbs
    }
  }

}

// Read Only Binding Role
resource "kubernetes_role_binding" "cluster_read_only_role_binding" {
  depends_on = [kubernetes_namespace.namespaces]

  for_each = { for k, v in var.namespaces : k => v }
  metadata {
    name      = "cluster-read-only-role-binding"
    namespace = each.value.name
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = "cluster-read-only-role"
  }

  subject {
    kind      = "Group"
    name      = "cluster-read-only-group"
    api_group = "rbac.authorization.k8s.io"
  }

}
