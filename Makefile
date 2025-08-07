init:
terraform init
plan:
terraform plan -var="project_id=terraform-iac-portfolio"
apply:
terraform apply -auto-approve -var="project_id=terraform-iac-portfolio"
destroy:
terraform destroy -auto-approve -var="project_id=terraform-iac-portfolio"