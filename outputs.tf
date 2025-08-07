output "vm_external_ip" {
 value = google_compute_instance.demo_vm.network_interface[0].access_config[0].nat_ip
}
output "bucket_url" {
 value = "https://storage.googleapis.com/${google_storage_bucket.demo_bucket.name}/"
}