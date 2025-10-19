#!/bin/bash
echo "🔧 GITOPS MANAGEMENT CONSOLE"
echo "============================"

while true; do
    echo ""
    echo "Select an option:"
    echo "1. 📊 View Status Dashboard"
    echo "2. 🚀 Start All Services"
    echo "3. 🔄 Update Application"
    echo "4. 📝 Make Quick Change"
    echo "5. 🔍 Check ArgoCD Status"
    echo "6. 🛑 Stop All Services"
    echo "7. ❌ Exit"
    echo ""
    read -p "Enter choice (1-7): " choice

    case $choice in
        1)
            ./gitops-dashboard.sh
            ;;
        2)
            ./start-all-services.sh
            ;;
        3)
            ./update-app.sh
            ;;
        4)
            read -p "Enter change description: " desc
            sed -i "s/GitOps Pipeline Successfully Deployed/GitOps Pipeline - $desc/" index.html
            git add index.html
            git commit -m "quick: $desc"
            git push origin main
            echo "✅ Change pushed! ArgoCD will auto-deploy."
            ;;
        5)
            echo "ArgoCD Applications:"
            kubectl get applications -n argocd
            ;;
        6)
            pkill -f "kubectl port-forward"
            echo "✅ All services stopped"
            ;;
        7)
            echo "👋 Goodbye!"
            exit 0
            ;;
        *)
            echo "❌ Invalid choice"
            ;;
    esac
done
