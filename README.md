# StreamAMG Infra Setup

## Overview
This repository provisions a **scalable, reliable, and event-driven video streaming platform** on AWS using Terraform. The architecture leverages ECS (Fargate) for API workloads, RDS for metadata, S3 and CloudFront for content delivery, Lambda for event-driven processing, and CloudWatch for observability—all following AWS best practices. All resources are deployed in the `eu-west-2` (London) region.

---

## Key Features
- **API Service (ECS Fargate):** Containerized API behind an Application Load Balancer (ALB)
- **Database (RDS):** PostgreSQL in private subnets
- **Content Storage & CDN:** S3 for video storage, CloudFront for global delivery
- **Event-Driven Processing:** Lambda triggered by S3 uploads
- **Observability:** CloudWatch logs and metrics for ECS and Lambda
- **Security:** Private networking, least-privilege IAM, secure content delivery
- **CI/CD:** Automated with GitHub Actions
- **Modular IaC:** Clean, reusable Terraform modules

---

## Final Architecture Diagram

![streamAMGArchitecture-202](https://github.com/user-attachments/assets/3337e003-db26-4658-abcc-30e3a6b8524a)


**Legend:**
- **CloudFront** (Global): Delivers video content from S3 to users worldwide
- **S3 Bucket** (eu-west-2): Stores video files
- **Lambda** (eu-west-2): Processes S3 events (e.g., video processing)
- **ALB** (Public Subnet): Entry point for API traffic
- **ECS (Fargate)** (Private Subnet): Runs API containers
- **RDS (Postgres)** (Private Subnet): Stores metadata
- **CloudWatch** (eu-west-2): Collects logs/metrics from ECS and Lambda
- **User**: Accesses content via CloudFront and API via ALB

---

## How the Architecture Satisfies the Challenge
- **Scalable:** S3, CloudFront, ECS, and ALB auto-scale with demand
- **Reliable:** Multi-AZ VPC, managed RDS, and AWS-managed services ensure high availability
- **Event-driven:** S3 triggers Lambda for real-time processing
- **Secure:** Private subnets for compute/data, public subnets only for ALB, least-privilege IAM
- **Observability:** CloudWatch logs and metrics for ECS and Lambda
- **CI/CD:** GitHub Actions automates deployment and testing
- **Modular & Human-readable:** Clean Terraform modules and clear documentation

---

## Setup & Deployment

### Prerequisites
- AWS account with programmatic access
- AWS credentials set as GitHub Secrets:
  - `AWS_ACCESS_KEY_ID`
  - `AWS_SECRET_ACCESS_KEY`
  - `AWS_DEFAULT_REGION` (set to `eu-west-2`)
- [Terraform](https://www.terraform.io/) (for local testing)
- [GitHub Actions](https://docs.github.com/en/actions) (for CI/CD)

### Local Deployment
```sh
cd terraform
terraform init
terraform apply -auto-approve
```

### CI/CD Deployment (Recommended)
- Push changes to `main` branch or trigger manually in GitHub Actions.
- The workflow will:
  - Build a Lambda deployment package
  - Run `terraform init`, `validate`, `plan`, and (optionally) `apply`
  - Deploy all infra to `eu-west-2`

---

## CI/CD Pipeline
- **GitHub Actions** automates infrastructure deployment:
  - On push to `main` or manual trigger
  - Builds Lambda zip on-the-fly
  - Runs Terraform commands
  - Uses AWS credentials from GitHub Secrets
- See `.github/workflows/infra-deploy.yml` for details

---

## How to Validate
- **ECS/ALB:** Visit ALB DNS, see nginx welcome page
- **S3/CloudFront:** Upload file to S3, access via CloudFront domain
- **RDS:** Check status in AWS Console
- **Lambda:** Upload file to S3, check Lambda logs in CloudWatch
- **CloudWatch:** View logs and alarms

---

## AI Usage Documentation
I used ChatGPT to help with troubleshooting and fix issues faster. It was useful for setup, but I still reviewed everything myself to make sure it worked correctly for StreamAMG Infra setup.

---

## Troubleshooting & Lessons Learned
- **NAT Gateway & Private Subnets:** Required for ECS tasks to pull images from ECR
- **Security Groups:** Outbound rules must allow all for ECS tasks
- **VPC DNS Hostnames:** Must be enabled for ECS/ECR connectivity
- **Lambda Deployment:** Automated zip build in CI/CD to avoid missing file errors
- **Region Consistency:** All resources and workflows set to `eu-west-2`

---

## Assumptions & Simplifications
- Demo app uses public nginx image; can be swapped for real app
- Lambda uses a minimal Python handler for demo
- CI/CD auto-apply is commented for safety

---
