resource "oci_core_instance" "ubuntu_instance" {
  # Required
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = var.compartment_ocid
  shape               = "VM.Standard.E2.1.Micro"

  source_details {
    source_id   = data.oci_core_images.ubuntu.images[0].id
    source_type = "image"
  }

  create_vnic_details {
    assign_public_ip = true
    subnet_id        = oci_core_subnet.subnet.id

    
   metadata {
    ssh_authorized_key = var.public_key
  }
}