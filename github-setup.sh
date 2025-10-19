#!/bin/bash
echo "🎯 COMPLETE GITHUB SETUP"
echo "========================"

echo "1. Removing existing remote..."
git remote remove origin

echo "2. Setting correct remote URL..."
git remote add origin https://github.com/nanado002/devsecops-gitops-demo.git

echo "3. Current remote:"
git remote -v

echo ""
echo "🎯 BEFORE CONTINUING:"
echo "1. Create repository at: https://github.com/new"
echo "   - Name: devsecops-gitops-demo"
echo "   - Public, NO README, NO .gitignore, NO license"
echo ""
echo "2. Create token at: https://github.com/settings/tokens"
echo "   - Scopes: repo, workflow"
echo ""
echo "3. Press Enter after completing both steps..."
read

echo "4. Pushing to GitHub..."
echo "When prompted:"
echo "  Username: nanado002"
echo "  Password: [your personal access token]"
echo ""
git push -u origin main

if [ $? -eq 0 ]; then
    echo "✅ SUCCESS! Your repository is at:"
    echo "   https://github.com/nanado002/devsecops-gitops-demo"
else
    echo "❌ Push failed. Check if:"
    echo "   - Repository exists"
    echo "   - Token is correct"
    echo "   - No typos in URL"
fi
