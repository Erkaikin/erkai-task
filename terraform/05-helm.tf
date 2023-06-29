#####################################
### HELM RELEASES
#####################################

# nginx ingress controller helm chart
resource "helm_release" "ingress-nginx" {
  name       = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = "4.4.0"
  namespace  = "ingress-nginx"
  create_namespace = "true"
  timeout    = 600

  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-type"
    value = "60"
    type  = "string"
  }
  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-cross-zone-load-balancing-enabled"
    value = "true"
    type  = "string"
  }
  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-ssl-cert"
    value = aws_acm_certificate.eks_domain_cert.arn
    type  = "string"
  }
  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-ssl-ports"
    value = "https"
    type  = "string"
  }
  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-ssl-negotiation-policy"
    value = "ELBSecurityPolicy-TLS-1-2-2017-01"
    type  = "string"
  }
  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-type"
    value = "nlb"
    type  = "string"
  }
  set {
    name  = "config.use-proxy-protocol"
    value = "true"
    type  = "string"
  }
  set {
    name  = "config.real-ip-header"
    value = "proxy_protocol"
    type  = "string"
  }
  set {
    name  = "controller.service.targetPorts.http"
    value = "http"
    type  = "string"
  }
  set {
    name  = "controller.service.targetPorts.https"
    value = "http"
    type  = "string"
  }
}

data "kubernetes_service" "ingress_gateway" {
  metadata {
    name      = "ingress-nginx-controller"
    namespace = helm_release.ingress-nginx.namespace
  }
  depends_on = [helm_release.ingress-nginx]
}