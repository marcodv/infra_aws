// Apply the server manifest during eks fails.
// Need to find a way to pass it after deploy EKS
data "kubectl_file_documents" "metrics_server" {
  content = file("${path.module}/manifests/metrics_server/metrics_server.yaml")
} 

resource "kubectl_manifest" "setup_metrics_server" {
  depends_on = [aws_eks_cluster.eks_cluster]
  for_each   = data.kubectl_file_documents.metrics_server.manifests
  yaml_body  = each.value
}
