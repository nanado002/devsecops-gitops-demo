#!/bin/bash
echo "⚡ QUICK UPDATE"
echo "=============="

# Get current timestamp
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

# Update the deployment timestamp
sed -i "s/Last CI\/CD Run:.*/Last CI\/CD Run: $TIMESTAMP/" index.html

# Commit and push
git add index.html
git commit -m "update: refresh deployment timestamp"
git push origin main

echo "✅ Update pushed! ArgoCD will deploy within seconds."
echo "Watch: https://localhost:8443"
echo "View: http://localhost:28081"
