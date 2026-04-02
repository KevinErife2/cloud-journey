# Cloud Journey (Public Proof Log)
**Why I'm here**

I’m transitioning into cloud to build a durable career, solve real problems, and create
options for my family.

**My Focus (next 90 days)**
- AWS foundations (IAM, S3, EC2, CloudWatch)
- IaC with Terraform
- Documenting every build (README, screenshots, LinkedIn)
  
**Week 1 – Identity & First Wins**
- Set up GitHub + LinkedIn for cloud visibility
- Wrote this public proof log
- Next up: S3 + IAM “Public Access Problem” lab
  
**Projects (live/soon)**
(whatever projects or workshops you will do)

**How I document**
Each project includes: problem → approach → commands/code → screenshots →
lessons learned → what I'd do differently.

**Contact/Connect**
- LinkedIn: <(https://www.linkedin.com/in/kevin-e2/)>
- Notes: If you’re hiring for junior cloud/security roles, I’m documenting proof every
week.




** **Project 1 - Public Access Issue in AWS S3**

## Problem Statement
A public e-commerce site (CloudMart) experienced downtime when images stored in
S3 became inaccessible due to misconfigured bucket permissions.

## Investigation Process
- Reproduced the Access Denied issue.
- Reviewed S3 public access settings.
- Compared IAM roles and bucket policies.
  
## Solution
Implemented a least-privilege S3 bucket policy allowing controlled public object access.

## Validation
- Tested object URLs in a browser, verified public access.
- Confirmed no unauthorized uploads possible.
  
## Result
Product images restored.
Permissions secured.
Cost: $0 (AWS Free Tier). 

## Skills Highlighted
AWS S3 • IAM • Cloud Security • Troubleshooting • Documentation



** **Project 2 - The Down Server Dilemma (EC2 + VPC)**

## Problem Statement

A client dashboard hosted on EC2 experienced intermittent downtime because the server’s public IP changed after restarts, causing users to lose access to critical reports.

## Investigation Process
Reviewed EC2 instance networking and VPC configuration.
Observed that the instance was using a dynamic public IP, which changed after every stop/start.
Examined Security Groups, subnets, and route tables for proper access.

## Solution
Launched EC2 instances inside a custom VPC with a public subnet.
Configured Security Groups to allow SSH and HTTP access securely.
Allocated and associated an Elastic IP to the EC2 instance for persistent access.
Added CloudWatch alarms to monitor CPU utilization and system health.

## Validation
Tested the EC2 public IP after multiple reboots → remained stable.
Verified dashboard accessibility from client networks.
Confirmed secure SSH access and HTTP availability.

## Result
Client dashboard remains reliably accessible.
Downtime from IP changes eliminated.
Real-time monitoring alerts set up with CloudWatch and SNS.
Cost: $0 (AWS Free Tier for t3.micro instance and CloudWatch metrics).

## Skills Highlighted
AWS EC2 • VPC • Elastic IP • Security Groups • CloudWatch • SNS Alerts • Troubleshooting • Networking • Automation • Business Reliability
