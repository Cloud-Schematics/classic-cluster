# IKS on Classic Cluster 

This module creates an IKS on classic cluster with worker pools in any number of zones.

![Classic Cluster](./.docs/classic_cluster.png)
---

### Table of Contents
1. [Cluster](##cluster)
2. [Module Variables](##Module-Variables)
3. [Outputs](##Outputs) (optional)
4. [As a Module in a Larger Architecture](##As-a-Module-in-a-Larger-Architecture)

---

## Cluster

This module creates an IKS cluster, it will also optionall provision workers in multiple zones from a list. 

---

## Module Variables

Name                  | Type                                                                           | Description                                                                                         | Sensitive | Default
--------------------- | ------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------------------- | --------- | ---------------------
ibmcloud_api_key      | string                                                                         | The IBM Cloud platform API key needed to deploy IAM enabled resources                               | true      | 
iaas_classic_username | string                                                                         | Classic username key used to initialize the provider                                                | true      | 
iaas_classic_api_key  | string                                                                         | Classic API key used to initialize the provider                                                     | true      | 
resource_group        | string                                                                         | Name of resource group where all infrastructure will be provisioned                                 |           | gcat-landing-zone-dev
TF_VERSION            |                                                                                | The version of the Terraform engine that's used in the Schematics workspace.                        |           | 1.0
region                | string                                                                         | Region where VPC will be created                                                                    |           | us-south
vlan                  | object( { zone = string private = string public = optional(string) } )         | VLAN where the default worker pool and master node will be provisioned.                             |           | 
multizone_vlans       | list( object( { zone = string private = string public = optional(string) } ) ) | List of additional VLANs                                                                            |           | []
cluster_name          | string                                                                         | Name of openshift cluster to be created                                                             |           | classic-cluster
kube_version          | string                                                                         | Kube version to use for the cluster. use `ibmcloud ks versions` to see a list of available versions |           | 1.21.7
default_pool_size     | number                                                                         | Default pool size for cluster                                                                       |           | 1
hardware              | string                                                                         | Hardware type for cluster, shared or dedicated                                                      |           | shared
machine_type          | string                                                                         | hardware type for cluster                                                                           |           | b3c.4x16

---

## Outputs

Name       | Description                                                  | Sensitive | Depends On                                               | Value
---------- | ------------------------------------------------------------ | --------- | -------------------------------------------------------- | ----------------------------------------
cluster_id | Cluster ID, will await multizone attachment before returning |           | [ ibm_container_worker_pool_zone_attachment.multi_zone ] | ibm_container_cluster.classic_cluster.id


---

## As a Module in a Larger Architecture

```terraform
module classic_cluster {
  source                = "./classic_cluster"
  resource_group        = var.resource_group
  region                = var.region
  vlan                  = var.vlan
  multizone_vlans       = var.multizone_vlans
  cluster_name          = var.cluster_name
  kube_version          = var.kube_version
  default_pool_size     = var.default_pool_size
  hardware              = var.hardware
  machine_type          = var.machine_type
}
```
