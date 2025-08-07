# GCP Terraform Infrastructure as Code

A lightweight Terraform configuration for provisioning basic Google Cloud Platform infrastructure using always-free tier resources. This project demonstrates Infrastructure as Code (IaC) best practices for GCP deployments with automated lifecycle management.

## 🏗️ Infrastructure Components

### Compute Resources
- **Compute Engine VM**: f1-micro instance (always-free tier eligible)
  - Location: us-west1-b zone
  - OS: Debian 11
  - Network: Default VPC with ephemeral external IP
  - Tags: `http-server` for firewall targeting

### Storage Resources
- **Cloud Storage Bucket**: Regional bucket with lifecycle management
  - Location: US multi-region
  - Auto-deletion: Objects older than 30 days
  - Force destroy enabled for easy cleanup

### Network Security
- **Firewall Rules**: HTTP traffic allowed on port 80
  - Protocol: TCP
  - Port: 80
  - Target: Instances with `http-server` tag

## 📋 Prerequisites

1. **Google Cloud Platform Account**
   - Active GCP project with billing enabled
   - Compute Engine API enabled
   - Cloud Storage API enabled

2. **Local Development Environment**
   - [Terraform](https://www.terraform.io/downloads.html) >= 1.0
   - [Google Cloud SDK](https://cloud.google.com/sdk/docs/install)
   - Make utility (for automated commands)

3. **Authentication Setup**
   ```bash
   # Login to GCP
   gcloud auth login
   gcloud auth application-default login
   
   # Set your default project
   gcloud config set project YOUR_PROJECT_ID
   ```

## 🚀 Quick Start

### 1. Clone and Initialize
```bash
git clone <repository-url>
cd GCP-Terraform-Infrastructure-as-Code
make init
```

### 2. Plan Deployment
```bash
make plan
```
This will show you exactly what resources will be created before applying changes.

### 3. Deploy Infrastructure
```bash
make apply
```
Automatically deploys all resources with the project ID `terraform-iac-portfolio`.

### 4. Clean Up Resources
```bash
make destroy
```
Completely removes all provisioned infrastructure to avoid ongoing costs.

## ⚙️ Configuration

### Variables
The infrastructure can be customized through the following variables:

| Variable | Type | Default | Description |
|----------|------|---------|-------------|
| `project_id` | string | *required* | Your GCP Project ID |
| `bucket_name` | string | `iac-demo-bucket` | Cloud Storage bucket name |
| `vm_name` | string | `iac-demo-vm` | Compute Engine instance name |

### Custom Deployment
To deploy with a different project ID or custom names:
```bash
terraform apply \
  -var="project_id=your-project-id" \
  -var="bucket_name=my-custom-bucket" \
  -var="vm_name=my-custom-vm"
```

## 📤 Outputs

After successful deployment, the following information will be displayed:

- **VM External IP**: Public IP address of the Compute Engine instance
- **Bucket URL**: Direct HTTPS URL to access the Cloud Storage bucket

Example output:
```
vm_external_ip = "34.82.XXX.XXX"
bucket_url = "https://storage.googleapis.com/iac-demo-bucket/"
```

## 💰 Cost Optimization Features

### Always-Free Tier Usage
- **f1-micro VM**: Eligible for Google Cloud's always-free tier (1 VM per month)
- **Regional Storage**: First 5GB of regional Cloud Storage is free monthly
- **Network Egress**: 1GB of egress from North America is free monthly

### Automated Lifecycle Management
- **Storage Lifecycle**: Automatic deletion of objects after 30 days prevents storage accumulation
- **Force Destroy**: Enables complete infrastructure cleanup without manual intervention
- **Ephemeral IP**: Uses auto-assigned IP instead of reserved static IP to avoid charges

## 🛠️ Makefile Commands

| Command | Description |
|---------|-------------|
| `make init` | Initialize Terraform working directory |
| `make plan` | Preview infrastructure changes |
| `make apply` | Deploy infrastructure automatically |
| `make destroy` | Remove all provisioned resources |

## 📁 Project Structure

```
├── .gitignore          # Terraform state and lock file exclusions
├── LICENSE             # MIT License
├── Makefile           # Automated deployment commands
├── README.md          # This documentation
├── main.tf            # Core infrastructure resources
├── outputs.tf         # Output definitions
├── provider.tf        # GCP provider configuration
└── variables.tf       # Input variable definitions
```

## 🔒 Security Considerations

- **Firewall Rules**: Only HTTP (port 80) traffic is allowed
- **Network Access**: VM uses default VPC with standard security groups
- **State Management**: Terraform state is stored locally (consider remote backend for production)
- **Credentials**: Uses Application Default Credentials (ADC) for authentication

## 🚨 Important Notes

- **Billing**: While using free-tier resources, ensure billing is enabled on your GCP project
- **Quotas**: Verify you haven't exceeded free-tier quotas before deployment
- **State Files**: Keep `.tfstate` files secure and backed up for production use
- **Resource Naming**: Bucket names must be globally unique across all of GCP
