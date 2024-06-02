resource "helm_release" "argocd" {
  name       = "argocd"
  namespace  = var.namespace
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "7.0.0"

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

resource "kubectl_manifest" "argocd_manifest" {
  depends_on = [helm_release.argocd, kubernetes_secret.argocd_ssh_key]
  yaml_body  = <<YAML
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: infra-apps
  namespace: argocd
  finalizers:
    - resources-finalizer.argocd.argoproj.io
spec:
  project: default
  source:
    repoURL: "git@gitlab.com:orondevops1/gitops-config.git"
    targetRevision: main
    path: infra/apps
  destination:
    server: https://kubernetes.default.svc
    namespace: argocd
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
YAML

}




