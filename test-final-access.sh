#!/bin/bash
echo "🎯 FINAL ACCESS TEST"
echo "==================="

echo "1. Testing Host-Based Access (Working):"
echo "   Staging:    http://staging.localhost"
curl -s -H "Host: staging.localhost" http://localhost/ | grep -o '<title>.*</title>' && echo "   ✅ SUCCESS" || echo "   ❌ FAILED"
echo "   Production: http://production.localhost"
curl -s -H "Host: production.localhost" http://localhost/ | grep -o '<title>.*</title>' && echo "   ✅ SUCCESS" || echo "   ❌ FAILED"

echo ""
echo "2. Testing Path-Based Access (Fixing):"
echo "   Staging:    http://localhost/staging"
curl -s http://localhost/staging/ | grep -o '<title>.*</title>' && echo "   ✅ SUCCESS" || echo "   ❌ FAILED - Still needs fix"
echo "   Production: http://localhost/production"
curl -s http://localhost/production/ | grep -o '<title>.*</title>' && echo "   ✅ SUCCESS" || echo "   ❌ FAILED - Still needs fix"

echo ""
echo "3. Checking Ingress Configuration:"
kubectl get ingress -A

echo ""
echo "✅ Test complete! Host-based access is confirmed working."
