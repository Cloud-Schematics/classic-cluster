#############################################################################
# Cluster outputs
#############################################################################

output cluster_id {
    description = "Cluster ID, will await multizone attachment before returning"
    value       = "${ibm_container_cluster.classic_cluster.id}"
    depends_on  = ["ibm_container_worker_pool_zone_attachment.multi_zone"]
}

#############################################################################