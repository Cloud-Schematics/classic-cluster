# Name
Short Description

![arch image](path)
---

### Table of Contents
1. Resource headers
2. [Module Variables](##Module-Variables)
3. [Outputs](##Outputs) (optional)
4. [As a Module in a Larger Architecture](##As-a-Module-in-a-Larger-Architecture)

---
## Resource headers
Add as many resource headers here as you want

---
## Module Variables

Variable | Type | Description | Default
---------|------|-------------|--------
`ibmcloud_api_key` | String | IBM Cloud IAM API Key |
`resource_group` | String | Name of resource group to provision resources |
`ibm_region` | String | IBM Cloud region where all resources will be deployed | `us-south`
`public_vlan_ids` | list | List of public vlans. The first will be for the master, any additional will be for worker pools |
`private_vlan_ids` | list | List of private vlans The first will be for the master, any additional will be for worker pools |
`zones` | list | List of cluster zones The first will be for the master, any additional will be for worker pools |
`cluster_name` | String | Name of openshift cluster to be created | `classic-cluster`
`default_pool_size` | String | Default pool size for cluster | `1`
`hardware` | String | Hardware type for cluster, shared or dedicated | `shared`
`machine_type` | String | hardware type for cluster | `b2c.4x16`
---
## Outputs

---
## As a Module in a Larger Architecture

