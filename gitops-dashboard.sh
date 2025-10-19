#!/bin/bash
echo "🚀 COMPLETE GITOPS DASHBOARD"
echo "============================"
echo "Timestamp: $(date)"
echo ""

echo "📦 KUBERNETES CLUSTER:"
kubectl cluster-info | head -2

echo -e "\n🏗️  APPLICATION STATUS:"
echo "Staging:"
kubectl get pods,svc -n staging
echo -e "\nProduction:"
kubectl get pods,svc -n production

echo -e "\n🔄 ARGOCD STATUS:"
kubectl get applications -n argocd

echo -e "\n🔗 GITHUB REPOSITORY:"
echo "https://github.com/nanado002/devsecops-gitops-demo"

echo -e "\n🌐 ACCESS POINTS:"
echo "Staging App:     http://localhost:28081"
echo "Production App:  http://localhost:28082"
echo "ArgoCD Dashboard: https://localhost:8443"
echo "  Username: admin"
echo "  Password: rSVJOukurphWN40G"

echo -e "\n🎯 GITOPS PIPELINE FLOW:"
echo "1. Code Change → git push"
echo "2. GitHub Actions → Build & Scan"
echo "3. ArgoCD → Auto-sync to Kubernetes"
echo "4. Application → Updated automatically"

echo -e "\n✅ YOUR GITOPS PIPELINE IS READY!"
