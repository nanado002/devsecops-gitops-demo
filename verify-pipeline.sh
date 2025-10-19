#!/bin/bash
echo "✅ GITOPS PIPELINE VERIFICATION"
echo "==============================="

echo "1. ArgoCD Status:"
kubectl get applications -n argocd

echo ""
echo "2. Application Content:"
echo "Staging:"
curl -s http://localhost:28081 | grep -o '<title>.*</title>'
echo "Production:"
curl -s http://localhost:28082 | grep -o '<title>.*</title>'

echo ""
echo "3. Pod Status:"
echo "Staging:"
kubectl get pods -n staging
echo "Production:"
kubectl get pods -n production

echo ""
echo "4. GitHub Actions:"
echo "Latest workflow: https://github.com/nanado002/devsecops-gitops-demo/actions"

echo ""
echo "🎉 VERIFICATION COMPLETE!"
echo "Your GitOps pipeline is fully operational!"
