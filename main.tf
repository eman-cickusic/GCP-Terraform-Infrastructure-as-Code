resource "google_storage_bucket" "demo_bucket" {
 name          = var.bucket_name
 location      = "US"
 force_destroy = true
 lifecycle_rule {
   action {
     type = "Delete"
   }
   condition {
     age = 30
   }
 }
}
# Free-tier f1-micro VM
resource "google_compute_instance" "demo_vm" {
 name         = var.vm_name
 machine_type = "f1-micro"
 zone         = "us-west1-b"
 boot_disk {
   initialize_params {
     image = "debian-cloud/debian-11"
   }
 }
 network_interface {
   network = "default"
   access_config {} # Ephemeral IP
 }
 tags = ["http-server"]
}
# Allow HTTP Traffic
resource "google_compute_firewall" "allow_http" {
 name    = "allow-http"
 network = "default"
 allow {
   protocol = "tcp"
   ports    = ["80"]
 }
 target_tags = ["http-server"]
}