resource "helm_release" "argocd" {
  name       = "argocd"
  namespace  = var.namespace
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "4.5.0"

  set {
    name  = "server.service.type"
    value = "ClusterIP"
  }
}

data "kubernetes_service" "argocd" {
  metadata {
    namespace = helm_release.argocd.namespace
    name      = "argocd-server"
  }
}

resource "kubernetes_namespace" "argocd" {
  metadata {
    name = var.namespace
  }
}

resource "kubernetes_namespace" "car-app" {
  metadata {
    name = "car-app"
  }
}

resource "kubernetes_namespace" "cert-manager" {
  metadata {
    name = "cert-manager"
  }
}

resource "kubernetes_namespace" "ingress-nginx" {
  metadata {
    name = "ingress-nginx"
  }
}

resource "kubernetes_namespace" "prometheus-stack" {
  metadata {
    name = "monitoring"
  }
}





