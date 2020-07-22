
##############################################################################
# Create Cluster
##############################################################################

resource ibm_container_cluster classic_cluster {

    name              = var.cluster_name
    resource_group_id = var.resource_group_id
    datacenter        = element(var.zones, 0)
    machine_type      = var.machine_type
    kube_version      = var.kube_version
    hardware          = var.hardware
    public_vlan_id    = var.private_only ? null : element(var.public_vlan_ids, 0)
    private_vlan_id   = element(var.private_vlan_ids, 0)
    default_pool_size = var.default_pool_size

}

#############################################################################


#############################################################################
# Create multizone attachments for cluster
#############################################################################

resource ibm_container_worker_pool_zone_attachment multi_zone {
    count             = length(var.zones) - 1
    resource_group_id = var.resource_group_id
    cluster           = ibm_container_cluster.classic_cluster.name
    worker_pool       = ibm_container_cluster.classic_cluster.worker_pools.0.id
    zone              = element(var.zones, count.index + 1)
    public_vlan_id    = var.private_only ? null : element(var.public_vlan_ids, count.index + 1)
    private_vlan_id   = element(var.private_vlan_ids, count.index + 1)
}

#############################################################################
