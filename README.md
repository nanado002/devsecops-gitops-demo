🚀 DevSecOps GitOps Pipeline - Complete Setup Guide
A complete enterprise-grade GitOps CI/CD pipeline with Kubernetes, ArgoCD, GitHub Actions, and multi-environment deployment.

📋 Table of Contents
Architecture Overview

Prerequisites

Quick Start

Project Structure

Management Scripts

Access URLs

GitOps Workflow

Troubleshooting

🏗️ Architecture Overview
text
Developer → Git Push → GitHub Actions → ArgoCD → Kubernetes → Live Applications
                     ↓              ↓
               Security Scan    Auto-Sync
                     ↓              ↓
               Container Build  Multi-Environment
⚡ Prerequisites
Docker Desktop with Kubernetes enabled

WSL2 (Windows) or Linux/macOS terminal

Git installed

GitHub account with repository access

🚀 Quick Start
1. Clone and Setup Project
bash
# Clone the repository
git clone https://github.com/nanado002/devsecops-gitops-demo.git
cd devsecops-gitops-demo

# Set up Git configuration
git config user.email "your-email@example.com"
git config user.name "Your Name"
2. Start Kubernetes and Applications
bash
# Start all services (run this first)
./start-all-services.sh

# Or run in background
./run-services-background.sh
3. Access Your Applications
Staging: http://staging.localhost

Production: http://production.localhost

ArgoCD Dashboard: https://localhost:8443 (admin/rSVJOukurphWN40G)

📁 Project Structure
text
devsecops-gitops-demo/
├── .github/workflows/          # GitHub Actions CI/CD
├── gitops/                     # GitOps configuration
│   ├── apps/                   # ArgoCD application definitions
│   ├── base/                   # Base Kubernetes manifests
│   └── environments/           # Environment-specific configs
├── index.html                  # Application code
├── Dockerfile                  # Container configuration
├── management-scripts/         # Utility scripts
└── README.md                   # This file
🛠️ Management Scripts
Core Management
bash
# Start all services (recommended)
./start-all-services.sh

# Run services in background
./run-services-background.sh

# Management console
./manage-gitops.sh

# Status dashboard
./gitops-dashboard.sh
Monitoring & Verification
bash
# Check pipeline status
./pipeline-status.sh

# Test all access methods
./test-everything.sh

# Verify complete setup
./verify-pipeline.sh

# Application status
./app-status.sh
Quick Operations
bash
# Quick application update
./quick-update.sh

# Update application content
./update-app.sh

# Stop all services
pkill -f 'kubectl port-forward'
🌐 Access URLs
Applications
Staging Environment: http://staging.localhost

Production Environment: http://production.localhost

Management Dashboards
ArgoCD GitOps: https://localhost:8443

Username: admin

Password: rSVJOukurphWN40G

GitHub Repository: https://github.com/nanado002/devsecops-gitops-demo

GitHub Actions: https://github.com/nanado002/devsecops-gitops-demo/actions

🔄 GitOps Workflow
Making Changes
Edit your application:

bash
# Edit the main application file
nano index.html
Commit and push:

bash
git add index.html
git commit -m "feat: description of changes"
git push origin main
Watch automation:

GitHub Actions runs automatically

ArgoCD detects changes and syncs

Applications update within 60 seconds

Quick Test Change
bash
# Make a quick visible change
./manage-gitops.sh
# Select option 4 for quick changes
⚙️ Core Components
Kubernetes Manifests
Located in gitops/ directory:

Base configuration: gitops/base/

Staging environment: gitops/environments/staging/

Production environment: gitops/environments/production/

ArgoCD Applications
Staging App: tic-tac-toe-staging

Production App: tic-tac-toe-production

GitHub Actions Pipeline
Automated CI/CD with:

Security scanning (Trivy)

Kubernetes manifest validation

Docker build testing

GitOps deployment notifications

🐛 Troubleshooting
Applications Not Accessible
bash
# Restart port forwarding
./start-all-services.sh

# Check status
./test-everything.sh

# Verify Kubernetes
kubectl get pods -A
ArgoCD Sync Issues
bash
# Check ArgoCD status
kubectl get applications -n argocd

# View ArgoCD logs
kubectl logs -n argocd -l app.kubernetes.io/name=argocd-server
GitHub Actions Not Running
Ensure repository is public

Check workflow file exists: .github/workflows/ci-cd.yaml

Verify push was successful: git push origin main

Port Conflicts
bash
# Stop everything and restart
pkill -f 'kubectl port-forward'
./start-all-services.sh
🔧 Advanced Operations
Manual Application Update
bash
# Update ConfigMap and restart
kubectl create configmap -n staging tic-tac-toe-html --from-file=index.html --dry-run=client -o yaml | kubectl apply -f -
kubectl rollout restart deployment/tic-tac-toe -n staging
Check Pod Logs
bash
# View application logs
kubectl logs -n staging -l app=tic-tac-toe
Kubernetes Diagnostics
bash
# Comprehensive cluster check
./diagnose-all.sh

# Resource status
kubectl get all -A
📈 Monitoring
Real-time Status
bash
# Live dashboard
./gitops-dashboard.sh

# Pipeline monitor
./monitor-pipeline.sh
Health Checks
bash
# Application health
curl -I http://staging.localhost

# ArgoCD health
curl -k -I https://localhost:8443
🚀 Production Notes
For Production Use
Use proper secrets management (HashiCorp Vault, Sealed Secrets)

Implement monitoring (Prometheus, Grafana)

Add security scanning in CI/CD pipeline

Configure proper ingress with TLS

Set up backup strategies

Scaling
Modify replicas in gitops/environments/production/kustomization.yaml

Add resource limits in gitops/base/deployment.yaml

📞 Support
Common Issues
Port 8080 busy: Use alternative ports or stop conflicting applications

Docker Desktop issues: Restart Docker Desktop and re-enable Kubernetes

Git authentication: Use Personal Access Tokens instead of passwords

Verification Checklist
Kubernetes cluster running (kubectl get nodes)

Applications deployed (kubectl get pods -A)

ArgoCD syncing (kubectl get applications -n argocd)

GitHub Actions configured (Repository → Actions tab)

Applications accessible (http://staging.localhost)

🎉 Success Verification
Your pipeline is fully operational when:

✅ Changes to index.html auto-deploy within 2 minutes

✅ GitHub Actions shows green checkmarks

✅ ArgoCD shows "Healthy" status

✅ Applications accessible via all URLs

✅ Management scripts work without errors

Happy GitOps Automation! 🚀

This project demonstrates a complete enterprise-grade CI/CD pipeline using modern GitOps practices with ArgoCD and Kubernetes.
