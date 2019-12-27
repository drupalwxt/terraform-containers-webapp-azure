variable "prefix" {
  description = "The prefix used for all resources in this example"
}

variable "location" {
  description = "The Azure location where all resources in this example should be created"
}

variable "subscription_id" {
  description = "The Subscription ID for the Service Principal to use for this Managed Kubernetes Cluster"
}

variable "client_id" {
  description = "The Client ID for the Service Principal to use for this Managed Kubernetes Cluster"
}

variable "client_secret" {
  description = "The Client Secret for the Service Principal to use for this Managed Kubernetes Cluster"
}

variable "tenant_id" {
  description = "The Tenant ID for the Service Principal to use for this Managed Kubernetes Cluster"
}
