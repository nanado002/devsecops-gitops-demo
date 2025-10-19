#!/bin/bash
echo "🌐 TESTING ALL ACCESS METHODS"
echo "============================"

echo "1. Testing Path-Based Ingress:"
echo "   Staging:    http://localhost/staging"
curl -s http://localhost/staging | grep -o '<title>.*</title>' || echo "   ❌ Failed"
echo "   Production: http://localhost/production"
curl -s http://localhost/production | grep -o '<title>.*</title>' || echo "   ❌ Failed"

echo ""
echo "2. Testing Host-Based Ingress:"
echo "   Staging:    http://staging.localhost"
curl -s -H "Host: staging.localhost" http://localhost | grep -o '<title>.*</title>' || echo "   ❌ Failed"
echo "   Production: http://production.localhost"
curl -s -H "Host: production.localhost" http://localhost | grep -o '<title>.*</title>' || echo "   ❌ Failed"

echo ""
echo "3. Testing Direct Port Forwarding:"
echo "   Staging:    http://localhost:28081"
curl -s http://localhost:28081 | grep -o '<title>.*</title>' || echo "   ❌ Failed (port forwarding not active)"
echo "   Production: http://localhost:28082"
curl -s http://localhost:28082 | grep -o '<title>.*</title>' || echo "   ❌ Failed (port forwarding not active)"

echo ""
echo "✅ Testing complete!"
