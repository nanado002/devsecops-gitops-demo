#!/bin/bash
echo "🚀 STARTING APPLICATIONS"
echo "========================"

# Stop any existing port forwarding
echo "1. Stopping existing port forwarding..."
pkill -f "kubectl port-forward"
sleep 3

# Check if pods are running
echo -e "\n2. Checking application status..."
echo "Staging pods:"
kubectl get pods -n staging -l app=tic-tac-toe
echo -e "\nProduction pods:"
kubectl get pods -n production -l app=tic-tac-toe

# Start port forwarding
echo -e "\n3. Starting port forwarding..."
echo "Starting staging on port 28081..."
kubectl port-forward -n staging svc/tic-tac-toe 28081:80 &
STAGING_PID=$!

echo "Starting production on port 28082..."
kubectl port-forward -n production svc/tic-tac-toe 28082:80 &
PRODUCTION_PID=$!

# Wait for port forwarding to establish
sleep 5

# Test connections
echo -e "\n4. Testing connections..."
echo "Staging test:"
curl -s --connect-timeout 10 http://localhost:28081 > /dev/null && echo "✅ Staging: SUCCESS" || echo "❌ Staging: FAILED"

echo "Production test:"
curl -s --connect-timeout 10 http://localhost:28082 > /dev/null && echo "✅ Production: SUCCESS" || echo "❌ Production: FAILED"

echo -e "\n5. Checking what's running in pods..."
STAGING_POD=$(kubectl get pods -n staging -l app=tic-tac-toe -o jsonpath='{.items[0].metadata.name}' 2>/dev/null)
if [ -n "$STAGING_POD" ]; then
    echo "Staging pod content:"
    kubectl exec -n staging $STAGING_POD -- ls -la /usr/share/nginx/html/ 2>/dev/null || echo "Could not check staging pod content"
fi

echo -e "\n🎯 ACCESS URLs:"
echo "Staging:    http://localhost:28081"
echo "Production: http://localhost:28082"
echo ""
echo "Note: Keep this terminal open or run in background with: ./start-apps.sh &"
echo "To stop: pkill -f 'kubectl port-forward'"
