data "aws_eks_cluster" "cluster" {
  name = var.cluster_name
}

data "aws_eks_cluster_auth" "cluster" {
  name = var.cluster_name
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }
}

terraform {
  required_providers {
    grafana = {
      source  = "grafana/grafana"
      version = ">= 1.10.0"
    }
  }
}

/*provider "grafana" {
  auth = "${var.grafana_access_credentials.username}:${var.grafana_access_credentials.password}"
  url = "http://localhost:3000"
} */
