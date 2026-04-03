# Setup Instructions for LUIT Students

## Before You Start

1. **Fork this repository** (click "Fork" button at top right)
2. **Clone YOUR fork:**
```bash
   git clone https://github.com/YOUR-GITHUB-USERNAME/luit-terraform-snapshot-lab.git
   cd luit-terraform-snapshot-lab
```

## Step-by-Step Setup

### 1. Install Prerequisites

- [ ] AWS Account created
- [ ] AWS CLI installed
- [ ] Terraform installed
- [ ] Git installed

#### Installing Terraform

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

### 2. Configure AWS
```bash
aws configure
```

Enter your credentials when prompted:
- AWS Access Key ID
- AWS Secret Access Key
- Default region (e.g., us-east-1)
- Output format (json)

### 3. Create Your Variables File
```bash
cp terraform.tfvars.example terraform.tfvars
nano terraform.tfvars  # or use any text editor
```

### 4. Find Your AMI ID

**For Amazon Linux 2:**
```bash
aws ec2 describe-images \
  --owners amazon \
  --filters "Name=name,Values=amzn2-ami-hvm-*-x86_64-gp2" \
  --query 'Images[0].ImageId' \
  --output text
```

**For Ubuntu 22.04:**
```bash
aws ec2 describe-images \
  --owners 099720109477 \
  --filters "Name=name,Values=ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*" \
  --query 'Images[0].ImageId' \
  --output text
```

Copy this ID into `terraform.tfvars` for the `my_ami` value.

### 5. Deploy!
```bash
# Initialize Terraform (downloads providers)
terraform init

# Preview what will be created
terraform plan

# Deploy the infrastructure
terraform apply
# Type "yes" when prompted
```

### 6. Access Your Apache Server
```bash
# Get the URL
terraform output apache_url

# Or visit: http://<your-public-ip>
```

You should see: **🎓 Welcome LUIT Students! 🎓**

### 7. Wait for Snapshots (~10 minutes)
```bash
# Check snapshot status
aws ec2 describe-snapshots --owner-ids self \
  --query 'Snapshots[*].[SnapshotId,State,Progress]' \
  --output table
```

### 8. Test Disaster Recovery
```bash
# Enable DR mode
terraform apply -var="disaster_recovery_mode=true"
# Type "yes"

# Get DR URL
terraform output dr_apache_url
```

### 9. Clean Up (Important!)
```bash
# Delete everything to avoid AWS charges
terraform destroy
# Type "yes"
```

## Need Help?

- 📧 Support Needed ‼️ in LUIT Academy
- 📺 Video Tutorial: [link to video]


## Common Issues

### Issue: "AMI not found"
**Solution:** Make sure you're using an AMI ID from YOUR AWS region.

### Issue: "Snapshot does not exist"
**Solution:** Run `terraform apply` first, wait 10 minutes, then enable DR mode.

### Issue: "Permission denied"
**Solution:** Check your AWS credentials with `aws sts get-caller-identity`
