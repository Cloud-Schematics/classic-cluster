##############################################################################
# IBM Cloud Provider
##############################################################################

provider ibm {
  ibmcloud_api_key      = var.ibmcloud_api_key
  iaas_classic_username = var.iaas_classic_username
  iaas_classic_api_key  = var.iaas_classic_api_key 
  ibmcloud_timeout      = 60
}

##############################################################################


##############################################################################
# Resource Group
##############################################################################

data ibm_resource_group resource_group {
  name = var.resource_group
}

##############################################################################



##############################################################################
# Create Cluster
##############################################################################

resource ibm_container_cluster classic_cluster {
  name              = var.cluster_name
  resource_group_id = data.ibm_resource_group.resource_group.id
  datacenter        = var.vlan.zone
  machine_type      = var.machine_type
  kube_version      = var.kube_version
  hardware          = var.hardware
  public_vlan_id    = var.vlan.public
  private_vlan_id   = var.vlan.private
  default_pool_size = var.default_pool_size
}

#############################################################################


#############################################################################
# Create multizone attachments for cluster
#############################################################################

locals {
  vlan_object = {
    for vlan in var.multizone_vlans:
    (vlan.private) => vlan
  }
}

resource ibm_container_worker_pool_zone_attachment multi_zone {
  for_each          = local.vlan_object
  resource_group_id = data.ibm_resource_group.resource_group.id
  cluster           = ibm_container_cluster.classic_cluster.name
  worker_pool       = ibm_container_cluster.classic_cluster.worker_pools.0.id
  zone              = each.value.zone
  public_vlan_id    = each.value.public
  private_vlan_id   = each.value.private
}

#############################################################################
