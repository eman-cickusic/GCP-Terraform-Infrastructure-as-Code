variable "project_id" {
 type        = string
 description = "Your GCP Project ID"
}
variable "bucket_name" {
 type        = string
 default     = "iac-demo-bucket"
 description = "Cloud Storage Bucket Name"
}
variable "vm_name" {
 type        = string
 default     = "iac-demo-vm"
 description = "Name of the VM instance"
}