#!/bin/bash
echo "🚀 STARTING APPLICATIONS RELIABLY"
echo "================================"

# Function to check if port is available
check_port() {
    local port=$1
    if netstat -tulpn 2>/dev/null | grep -q ":$port "; then
        echo "Port $port is in use"
        return 1
    else
        echo "Port $port is available"
        return 0
    fi
}

# Function to wait for pod to be ready
wait_for_pod() {
    local namespace=$1
    local label=$2
    local timeout=60
    local counter=0
    
    echo "Waiting for pod in $namespace..."
    while [ $counter -lt $timeout ]; do
        if kubectl get pods -n $namespace -l $label --no-headers 2>/dev/null | grep -q "Running"; then
            echo "✅ Pod is running in $namespace"
            return 0
        fi
        sleep 2
        ((counter+=2))
    done
    echo "❌ Timeout waiting for pod in $namespace"
    return 1
}

# Stop existing port forwarding
echo "1. Stopping existing port forwarding..."
pkill -f "kubectl port-forward"
sleep 5

# Wait for pods to be ready
wait_for_pod staging "app=tic-tac-toe"
wait_for_pod production "app=tic-tac-toe"

# Start port forwarding
echo "2. Starting port forwarding..."
echo "Starting staging on port 28081..."
kubectl port-forward -n staging svc/tic-tac-toe 28081:80 &
STAGING_PID=$!

echo "Starting production on port 28082..."
kubectl port-forward -n production svc/tic-tac-toe 28082:80 &
PRODUCTION_PID=$!

echo "Starting ArgoCD on port 8443..."
kubectl port-forward -n argocd svc/argocd-server 8443:443 &
ARGOCD_PID=$!

# Wait for port forwarding to establish
echo "3. Waiting for connections to establish..."
sleep 8

# Test connections
echo "4. Testing connections..."
echo "Staging:"
curl -s --connect-timeout 10 http://localhost:28081 > /dev/null && echo "✅ Staging: SUCCESS" || echo "❌ Staging: FAILED"

echo "Production:"
curl -s --connect-timeout 10 http://localhost:28082 > /dev/null && echo "✅ Production: SUCCESS" || echo "❌ Production: FAILED"

echo "ArgoCD:"
curl -s --connect-timeout 10 -k https://localhost:8443 > /dev/null && echo "✅ ArgoCD: SUCCESS" || echo "❌ ArgoCD: FAILED"

echo ""
echo "🎯 ACCESS URLs:"
echo "Staging:    http://localhost:28081"
echo "Production: http://localhost:28082"
echo "ArgoCD:     https://localhost:8443"
echo ""
echo "Process IDs:"
echo "Staging: $STAGING_PID"
echo "Production: $PRODUCTION_PID"
echo "ArgoCD: $ARGOCD_PID"
echo ""
echo "To stop: pkill -f 'kubectl port-forward'"
echo "To restart: ./start-apps-reliable.sh"

# Keep script running to maintain port forwarding
wait
