// Namespaces definition

// Create namespaces with best practise from K8s docs
// https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md#metadata
 resource "kubernetes_namespace" "namespaces" {
  for_each = { for k, v in var.namespaces: k => v} //loop over the namespaces
  metadata {
    name = each.value.name
    annotations = {
      for annotation in each.value.custom_annotations: annotation.label => annotation.value
    }
    labels = {
      for label in each.value.custom_labels: label.label => label.value
    }
  }
}
  
