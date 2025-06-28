resource "oci_core_virtual_network" "vcn" {
  compartment_id = var.compartment_ocid
  cidr_block     = "10.0.0.0/16"
  display_name   = "simple-vcn"
}

resource "oci_core_internet_gateway" "ig" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.vcn.id
  display_name   = "internet-gateway"
  enabled        = true
}

resource "oci_core_route_table" "route" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.vcn.id
  display_name   = "default-route"

  route_rules {
    cidr_block        = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.ig.id
  }
}

resource "oci_core_subnet" "subnet" {
  compartment_id       = var.compartment_ocid
  vcn_id               = oci_core_virtual_network.vcn.id
  cidr_block           = "10.0.1.0/24"
  display_name         = "public-subnet"
  route_table_id       = oci_core_route_table.route.id
  prohibit_public_ip_on_vnic = false
}
