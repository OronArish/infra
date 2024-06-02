data "aws_secretsmanager_secret" "argocd_ssh_key" {
  name = var.argocd_ssh_secret_name
}

data "aws_secretsmanager_secret_version" "argocd_ssh_key_current" {
  secret_id = data.aws_secretsmanager_secret.argocd_ssh_key.id
}

resource "kubernetes_secret" "argocd_ssh_key" {
  depends_on = [helm_release.argocd]

  metadata {
    name      = "argocd-ssh-key"
    namespace = "argocd"

    labels = {
      "argocd.argoproj.io/secret-type" = "repository"
    }
  }

  data = {
    "url"         = "git@gitlab.com:orondevops1/gitops-config.git"
    name          = "ssh-gitlab",
    type          = "git"
    project       = "*",
    sshPrivateKey = data.aws_secretsmanager_secret_version.argocd_ssh_key_current.secret_string
  }
}
