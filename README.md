# 🚀 Fully Automated CI/CD Pipeline for Go Application using Docker, Kubernetes, Helm, Jenkins & ArgoCD

This project showcases a **fully automated CI/CD pipeline** for a production-grade **Go (Golang)** application using modern DevOps tools including **Docker**, **Kubernetes**, **Helm**, **Jenkins**, and **ArgoCD**. It covers everything from local testing and Dockerization to GitOps deployment with Helm and automated updates via Jenkins and ArgoCD.

## 📌 Key Features

- ✅ Develop & test Go application locally
- ✅ Dockerize application using a custom Dockerfile
- ✅ Run and test Docker container locally
- ✅ Deploy on Kubernetes using YAML manifests
- ✅ Create and manage Helm charts
- ✅ Automate deployment via ArgoCD (GitOps)
- ✅ Jenkins CI/CD pipeline with GitHub webhook
- ✅ Auto-tagging, pushing to GitHub, and continuous deployment


## 🛠️ Tech Stack

- **Go (Golang)**
- **Docker**
- **Kubernetes**
- **Helm**
- **ArgoCD**
- **Jenkins**
- **GitHub**


## ⚙️ CI/CD Workflow Overview

### 1. 🚧 Local Testing & Dockerization

- Develop and test your Go application locally.
- Create a `Dockerfile` to containerize the app.

```
bash
docker build -t my-go-app .
docker run -p 8080:8080 my-go-app
```

## 2. ☸️ Kubernetes Deployment (Manual Phase)

Create Kubernetes manifests:

- `deployment.yaml`
- `service.yaml`
- `ingress.yaml`

Apply them manually for initial testing:

```bash
kubectl apply -f k8s/
```

## 3. 📦 Helm Chart Setup

Create a Helm chart for reusable, version-controlled deployment of your Go application.

## 4. 🚀 ArgoCD for GitOps Deployment

ArgoCD is configured to continuously track the GitHub repository where the Helm chart is stored.

When a change is made to the Helm chart (for example, updating the Docker image tag in `values.yaml`), ArgoCD automatically:

- Detects the update
- Syncs the Helm chart with the target Kubernetes cluster
- Deploys the new version without manual intervention

This enables a fully automated GitOps-based deployment workflow.

## 5. 🔁 Jenkins CI/CD Pipeline

Jenkins is integrated with GitHub using webhooks. Whenever code is pushed to the repository, the Jenkins pipeline is triggered.

### CI/CD Pipeline Steps:

1. **Pull the updated code** from GitHub
2. **Run unit tests** on the Go application
3. **Build a new Docker image** with a unique version/tag
4. **Push the Docker image** to a container registry (e.g., Docker Hub or ECR)
5. **Update the image tag** in the Helm chart's `values.yaml`
6. **Commit and push** the updated Helm chart back to the GitHub repository

Once the updated Helm chart is pushed, ArgoCD automatically handles the deployment to Kubernetes.

## 6. ⚡ Continuous Delivery via ArgoCD

Once the updated Helm chart (with a new Docker image tag) is pushed to the GitHub repository, **ArgoCD automatically detects the change**.

ArgoCD then:

- Syncs the latest chart values with the Kubernetes cluster
- Automatically deploys the updated application version
- Ensures the cluster state matches the Git repository (GitOps principle)

This completes a fully automated **Continuous Delivery (CD)** process using **ArgoCD and Helm**, with **zero manual deployment steps** required.
