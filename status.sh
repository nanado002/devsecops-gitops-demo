#!/bin/bash
echo "📊 GITOPS PIPELINE STATUS - $(date)"
echo "==================================="

echo -e "\n🏗️  KUBERNETES STATUS:"
echo "Staging:"
kubectl get pods -n staging -o wide
echo -e "\nProduction:"
kubectl get pods -n production -o wide

echo -e "\n🌐 PORT FORWARDING STATUS:"
ps aux | grep "kubectl port-forward" | grep -v grep

echo -e "\n✅ APPLICATION STATUS:"
echo "Staging (http://localhost:28081):"
curl -s --connect-timeout 3 http://localhost:28081 > /dev/null && echo "🟢 ONLINE" || echo "🔴 OFFLINE"
echo "Production (http://localhost:28082):"
curl -s --connect-timeout 3 http://localhost:28082 > /dev/null && echo "🟢 ONLINE" || echo "🔴 OFFLINE"

echo -e "\n🎯 ACCESS URLs:"
echo "Staging:    http://localhost:28081"
echo "Production: http://localhost:28082"
echo ""
echo "Note: Port forwarding is running in background"
echo "Stop with: pkill -f 'kubectl port-forward'"
