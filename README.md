# Apache Snapshot & Disaster Recovery Lab

**Terraform Project**

This project teaches Infrastructure as Code (IaC) using Terraform to deploy an Apache web server with automated snapshot backups and disaster recovery capabilities.

---

## 📚 What I did

- ✅ Deploy EC2 instances with Terraform
- ✅ Install and configure Apache web server
- ✅ Create automated EBS snapshots
- ✅ Implement disaster recovery from snapshots
- ✅ Use Terraform variables and conditionals
- ✅ Work with security groups and user data

---

## 🏗️ Architecture
```
┌─────────────────────────────────────────────┐
│  Phase 1: Production Server                 │
│  ┌────────────┐                             │
│  │ EC2 + Apache│ → "Welcome LUIT Students!" │
│  └────────────┘                             │
│         ↓                                    │
│  ┌────────────┐                             │
│  │  Snapshot  │ (Automated Backup)          │
│  └────────────┘                             │
└─────────────────────────────────────────────┘

┌─────────────────────────────────────────────┐
│  Phase 2: Disaster Recovery                 │
│  ┌────────────┐                             │
│  │  Snapshot  │                             │
│  └────────────┘                             │
│         ↓                                    │
│  ┌────────────┐                             │
│  │ DR Server  │ → Restored from snapshot!   │
│  └────────────┘                             │
└─────────────────────────────────────────────┘
```

---

## 📋 Prerequisites

- AWS Account (Free Tier eligible)
- AWS CLI installed and configured
- Terraform installed (v1.0+)
- Basic command line knowledge

### Install Terraform

**macOS:**
```bash
brew install terraform
```

**Windows (Chocolatey):**
```bash
choco install terraform
```

**Linux:**
```bash
wget https://releases.hashicorp.com/terraform/1.7.0/terraform_1.7.0_linux_amd64.zip
unzip terraform_1.7.0_linux_amd64.zip
sudo mv terraform /usr/local/bin/
```

### Configure AWS CLI
```bash
aws configure
# Enter your:
# - AWS Access Key ID
# - AWS Secret Access Key
# - Default region (e.g., us-east-1)
# - Output format (json)
```

---

## 🚀 Quick Start

### 1. Clone the Repository
```bash
git clone https://github.com/YOUR-USERNAME/luit-terraform-snapshot-lab.git
cd luit-terraform-snapshot-lab
```

### 2. Set Up Your Variables
```bash
# Copy the example file
cp terraform.tfvars.example terraform.tfvars

# Edit with your values
nano terraform.tfvars
```

**Find your AMI ID:**
```bash
# Amazon Linux 2
aws ec2 describe-images \
  --owners amazon \
  --filters "Name=name,Values=amzn2-ami-hvm-*-x86_64-gp2" \
  --query 'Images[0].ImageId' \
  --output text

# Ubuntu 22.04
aws ec2 describe-images \
  --owners 099720109477 \
  --filters "Name=name,Values=ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*" \
  --query 'Images[0].ImageId' \
  --output text
```

### 3. Deploy the Infrastructure
```bash
# Initialize Terraform
terraform init

# Preview changes
terraform plan

# Deploy (creates production server + snapshots)
terraform apply
# Type "yes" when prompted
```

### 4. Access Your Apache Server
```bash
# Get the URL from output
terraform output apache_url

# Or visit: http://<your-public-ip>
```

You should see: **🎓 Welcome LUIT Students! 🎓**

### 5. Wait for Snapshots to Complete (~10 minutes)
```bash
# Check snapshot status
aws ec2 describe-snapshots --owner-ids self \
  --query 'Snapshots[*].[SnapshotId,State,Progress]' \
  --output table
```

### 6. Test Disaster Recovery
```bash
# Enable disaster recovery mode
terraform apply -var="disaster_recovery_mode=true"
# Type "yes"

# Get DR server URL
terraform output dr_apache_url

# Visit the DR URL - same webpage appears!
```

### 7. Return to Normal Operations
```bash
# Disable disaster recovery
terraform apply -var="disaster_recovery_mode=false"
# Type "yes"
```

### 8. Clean Up (Delete Everything)
```bash
terraform destroy
# Type "yes"
```

---

## 📁 Project Structure
```
luit-terraform-snapshot-lab/
├── main.tf                  # EC2 instance and volumes
├── snapshots.tf            # Snapshot creation logic
├── restore.tf              # Disaster recovery resources
├── variables.tf            # Variable definitions
├── outputs.tf              # Output values
├── provider.tf             # AWS provider configuration
├── terraform.tfvars.example # Example configuration
├── .gitignore              # Files to exclude from Git
├── README.md               # This file
└── scripts/
    ├── install_apache.sh   # Apache installation script
    └── check_snapshots.sh  # Snapshot verification script
```

---

## 🎓 Learning Exercises

### Exercise 1: Customize the Welcome Page
Modify `scripts/install_apache.sh` to change the welcome message.

### Exercise 2: Add More Snapshots
Change `snapshot_retention_count` in `terraform.tfvars` to keep more backups.

### Exercise 3: Multi-Region DR
Research how to copy snapshots to another AWS region for geographic redundancy.

### Exercise 4: Add Monitoring
Add CloudWatch alarms to alert when snapshots fail.

---

## 💰 Cost Estimate

- **EC2 t3.micro:** ~$0.01/hour (~$7/month)
- **EBS 20GB volume:** ~$2/month
- **Snapshots (7 days × 20GB):** ~$1/month
- **Total:** ~$10/month

**💡 Tip:** Run `terraform destroy` when not using to avoid charges!

---

## 🐛 Troubleshooting

### Error: "Snapshot does not exist"
**Solution:** You're trying to restore before snapshots are created. Run in two stages:
1. `terraform apply` (wait 10 minutes)
2. `terraform apply -var="disaster_recovery_mode=true"`

### Error: "AMI not found"
**Solution:** Update `my_ami` in `terraform.tfvars` with a valid AMI ID for your region.

### Apache not accessible
**Solution:** Check security group allows HTTP (port 80):
```bash
aws ec2 describe-security-groups --group-ids <your-sg-id>
```

---

## 📚 Additional Resources

- [Terraform Documentation](https://www.terraform.io/docs)
- [AWS EBS Snapshots](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSSnapshots.html)
- [Level Up In Tech](https://www.levelupintech.com/)

