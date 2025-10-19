#!/bin/bash
echo "🔍 PIPELINE MONITOR"
echo "=================="

echo "GitHub Actions Status:"
echo "https://github.com/nanado002/devsecops-gitops-demo/actions"
echo ""

echo "Recent commits:"
git log --oneline -3
echo ""

echo "Application Status:"
curl -s http://localhost:28081 > /dev/null && echo "🟢 Staging: Online" || echo "🔴 Staging: Offline"
curl -s http://localhost:28082 > /dev/null && echo "🟢 Production: Online" || echo "🔴 Production: Offline"
echo ""

echo "To trigger new deployment:"
echo "  make a change, then: git add . && git commit -m 'update' && git push"
echo ""
echo "Current content served:"
curl -s http://localhost:28081 | grep -o '<title>.*</title>'
