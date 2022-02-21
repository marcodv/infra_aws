// read the metrics server yaml file
data "kubectl_file_documents" "metrics_server" {
  content = file("${path.module}/manifests/metrics_server/metrics_server.yaml")
} 

// Apply the manifest using the kubectl_manifest
resource "kubectl_manifest" "setup_metrics_server" {
  depends_on = [aws_eks_node_group.node_group_eks]
  for_each   = data.kubectl_file_documents.metrics_server.manifests
  yaml_body  = each.value
}
