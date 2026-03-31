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

** Project 1
## Problem Statement
A public e-commerce site (CloudMart) experienced downtime when images stored in
S3 became inaccessible due to misconfigured bucket permissions.
## Investigation Process
- Reproduced the Access Denied issue.
- Reviewed S3 public access settings.
- Compared IAM roles and bucket policies.
## Solution
Implemented a least-privilege S3 bucket policy allowing controlled public object
access.
## Validation
- Tested object URLs in a browser, verified public access.
- Confirmed no unauthorized uploads possible.
## Result
✅ Product images restored.
✅ Permissions secured.
✅ Cost: $0 (AWS Free Tier). 

## Skills Highlighted
AWS S3 • IAM • Cloud Security • Troubleshooting • Documentation
