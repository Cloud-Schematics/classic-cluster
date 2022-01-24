##############################################################################
# Account Variables
# Copyright 2020 IBM
##############################################################################

# Comment this variable if running in schematics
variable ibmcloud_api_key {
  description = "The IBM Cloud platform API key needed to deploy IAM enabled resources"
  type        = string
  sensitive   = true
}

variable iaas_classic_username {
  description = "Classic username key used to initialize the provider"
  type        = string
  sensitive   = true
}

variable iaas_classic_api_key {
  description = "Classic API key used to initialize the provider"
  type        = string
  sensitive   = true
}

variable resource_group {
    description = "Name of resource group where all infrastructure will be provisioned"
    type        = string
    default     = "gcat-landing-zone-dev"

    validation  {
      error_message = "Unique ID must begin and end with a letter and contain only letters, numbers, and - characters."
      condition     = can(regex("^([a-z]|[a-z][-a-z0-9]*[a-z0-9])$", var.resource_group))
    }
}

# Comment out if not running in schematics
variable TF_VERSION {
 default     = "1.0"
 description = "The version of the Terraform engine that's used in the Schematics workspace."
}

variable region {
  description = "Region where VPC will be created"
  type        = string
  default     = "us-south"
}

##############################################################################


##############################################################################
# Network Variables
##############################################################################

variable vlan {
  description = "VLAN where the default worker pool and master node will be provisioned."
  type =     object(
    {
      zone    = string
      private = string
      public  = optional(string)
    }
  )
}

variable multizone_vlans {
  description = "List of additional VLANs"
  type        = list(
    object(
      {
        zone    = string
        private = string
        public  = optional(string)
      }
    )
  )
  default = []
}

##############################################################################


##############################################################################
# Cluster Variables
##############################################################################

variable cluster_name {
  description = "Name of openshift cluster to be created"
  type        = string
  default     = "classic-cluster"
}

variable kube_version {
  description = "Kube version to use for the cluster. use `ibmcloud ks versions` to see a list of available versions"
  type        = string
  default     = "1.21.7"
}

variable default_pool_size {
  description = "Default pool size for cluster"
  type        = number
  default     = 1  
}

variable hardware {
  description = "Hardware type for cluster, shared or dedicated"
  type        = string
  default     = "shared"
}

variable machine_type {
  description = "hardware type for cluster"
  type        = string
  default     = "b3c.4x16"
}

##############################################################################