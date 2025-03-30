# 🌍 Multi-Region Microservices on AWS with EKS, Terraform & CDK

This project showcases a production-ready infrastructure for deploying containerized microservices across multiple AWS regions using **EKS**, **Terraform**, and **AWS CDK**. It includes automated CI/CD pipelines, observability, and global traffic routing.

---

## 📌 Overview

- **Cloud:** AWS (EKS, ALB, Route 53, RDS/DynamoDB, CloudWatch)
- **IaC:** Terraform + AWS CDK (TypeScript)
- **CI/CD:** GitHub Actions
- **Containers:** Docker, Kubernetes, Helm/Kustomize
- **Monitoring:** Prometheus + Grafana
- **Optional:** Istio (Service Mesh)

---

## 🧱 Architecture

![Architecture Diagram](./diagrams/architecture.png)

- Two AWS regions: `us-east-1` and `eu-west-1`
- 3 microservices: `user`, `product`, `order`
- Each region hosts an independent EKS cluster
- Global DNS routing via Route 53
- CI/CD with GitHub Actions for deployment automation

---

## 🗂️ Repo Structure

```
multi-region-microservices/
🔺︎ infra/
🔺︎🔺︎ terraform/
🔺︎🔺︎🔺︎ modules/
🔺︎🔺︎🔺︎🔺︎ eks-cluster/
🔺︎🔺︎ us-east-1/
🔺︎🔺︎🔺︎ main.tf
🔺︎🔺︎ eu-west-1/
🔺︎🔺︎🔺︎ main.tf
🔺︎🔺︎ providers.tf
🔺︎🔺︎ backend.tf
🔺︎ cdk/
🔺︎ services/
🔺︎🔺︎ user/
🔺︎🔺︎ product/
🔺︎🔺︎ order/
🔺︎ ci-cd/
🔺︎🔺︎ github-actions/
🔺︎ k8s/
🔺︎🔺︎ manifests/
🔺︎ diagrams/
🔺︎🔺︎ architecture.png
🔺︎ README.md
```

---

## 🚀 Features

- ✅ Multi-region microservices with automatic failover
- ✅ Scalable and secure EKS clusters
- ✅ IaC with Terraform & CDK for full infra + service management
- ✅ GitHub Actions for build and deployment pipelines
- ✅ Monitoring with Prometheus & Grafana
- ✅ Latency-based routing via Route 53

---

## ⚙️ Deployment Steps

### 1. 📦 Infrastructure (Terraform)

```bash
cd infra/terraform
terraform init
terraform apply
```

#### Terraform State Backend
This project uses **S3 + DynamoDB** for remote state:
- Create an S3 bucket and DynamoDB table first (or use included module).
- Set values in `backend.tf` accordingly.

```hcl
terraform {
  backend "s3" {
    bucket         = "my-tf-state-johnny"
    key            = "multi-region/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
```

### 2. 💠 Deploy Services (CDK)

```bash
cd infra/cdk
npm install
cdk deploy
```

### 3. 🚀 CI/CD Pipeline

Set up GitHub secrets for:
- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `CDK_DEPLOY_REGION`
- `DOCKERHUB_USERNAME` / `DOCKERHUB_TOKEN`

Workflows will:
- Build & push Docker images
- Trigger CDK deployments

---

## 📊 Observability

- Dashboards available at `/grafana`
- Logs sent to CloudWatch (or Loki stack)
- Health checks configured via ALB

---

## 🌐 DNS & Traffic Routing

- Route 53 configured with **Latency-based Routing**
- Users are routed to the closest healthy region
- Failover to secondary region in case of downtime

---

## 🧪 Testing

To test regional routing:

```bash
curl -H "Host: myservice.example.com" http://<ALB-DNS>
```

Or use [globalping.io](https://globalping.io) to test from different regions.

---

## 💸 Cost Estimation

This setup uses:
- 2 EKS clusters
- Route 53
- Load balancers
- RDS/DynamoDB
- CloudWatch + Prometheus

Total expected cost (dev/test scale): **~$50–100/month**  
Use `infracost` to estimate before deploying.

---

## 📌 TODO

- [ ] Add Istio service mesh (optional)
- [ ] Enable secret management (e.g., SealedSecrets or AWS Secrets Manager)
- [ ] Add auto-scaling policies
- [ ] Publish architecture diagram

---

## 🧠 Learnings & Goals

This project demonstrates:
- Deploying fault-tolerant multi-region systems
- Automating everything via IaC
- Managing microservices in Kubernetes
- CI/CD best practices using GitHub Actions
- Building observable and monitorable platforms

---

## 🧑‍💻 Author

**Johnny Marquez**  
DevOps Engineer | [LinkedIn](https://linkedin.com/in/johnnymarquezv) | [GitHub](https://github.com/johnnymarquez)

---

