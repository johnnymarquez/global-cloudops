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
🔺︎🔺︎ route53/
🔺︎🔺︎🔺︎ main.tf
🔺︎🔺︎🔺︎ variables.tf
🔺︎🔺︎ providers.tf
🔺︎🔺︎ backend.tf
🔺︎ monitoring/
🔺︎🔺︎ values.yaml
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

## ⚙️ Manual Deployment Steps

### 📖 Prerequisites
- AWS CLI configured with credentials
- Terraform v1.3+
- CDK v2 (with `cdk` CLI installed)
- kubectl
- Helm
- Docker (if building locally)

### ⚡ Terraform Infra (Run from `infra/terraform/`)

```bash
terraform init
terraform apply -var-file="terraform.tfvars"
```

### 🚀 CDK App Deploy (Run from `infra/cdk/`)
```bash
npm install
cdk bootstrap aws://<account-id>/us-east-1
cdk bootstrap aws://<account-id>/eu-west-1
cdk deploy --all
```

### ⚓ Deploy Monitoring Stack (Per Cluster)
```bash
# For us-east-1
aws eks update-kubeconfig --region us-east-1 --name eks-us-east-1
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm upgrade --install monitoring prometheus-community/kube-prometheus-stack \
  --namespace monitoring --create-namespace \
  -f infra/monitoring/values.yaml

# For eu-west-1
aws eks update-kubeconfig --region eu-west-1 --name eks-eu-west-1
helm upgrade --install monitoring prometheus-community/kube-prometheus-stack \
  --namespace monitoring --create-namespace \
  -f infra/monitoring/values.yaml
```

### 🔧 Build and Push Services (example for user)
```bash
cd services/user
docker build -t <dockerhub-user>/user-service .
docker push <dockerhub-user>/user-service
```

### 🌐 Deploy with Helm (per service, per cluster)
```bash
aws eks update-kubeconfig --region us-east-1 --name eks-us-east-1
helm upgrade --install user-service ./services/user/chart \
  --set image.repository=<dockerhub-user>/user-service \
  --set image.tag=latest \
  --namespace user --create-namespace
```

### 🌍 View Grafana
```bash
kubectl get svc -n monitoring grafana
```
Open the external IP in browser:
```
http://<external-ip>:80
```
Login: admin / admin123

---

