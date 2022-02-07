data "kubectl_file_documents" "metrics_server" {
  content = file("${path.module}/manifests/metrics_server/metrics_server.yaml")
}

// Apply the manifest passed from kubectl_file_documents
resource "kubectl_manifest" "setup_metrics_server" {
  depends_on = [aws_eks_cluster.eks_cluster]
  for_each   = data.kubectl_file_documents.metrics_server.manifests
  yaml_body  = each.value
}
