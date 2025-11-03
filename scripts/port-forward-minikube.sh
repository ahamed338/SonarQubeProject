#!/bin/bash

echo "🌐 Starting port forwarding for Minikube..."

# Kill any existing port-forward processes
echo "Cleaning up existing port-forward sessions..."
pkill -f "kubectl port-forward" || true
sleep 3

# Start Argo CD port forwarding
echo "Starting Argo CD on port 8080..."
kubectl port-forward svc/argocd-server -n argocd 8080:443 --address 0.0.0.0 > /dev/null 2>&1 &

# Start SonarQube port forwarding (wait for service to exist)
echo "Waiting for SonarQube service..."
sleep 10
kubectl port-forward svc/sonarqube-sonarqube -n sonarqube 9000:9000 --address 0.0.0.0 > /dev/null 2>&1 &

# Wait for port-forward to establish
sleep 5

# Get credentials
ARGO_PASSWORD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d 2>/dev/null || echo "unknown")

echo ""
echo "✅ Port forwarding active!"
echo ""
echo "🌐 Access your applications:"
echo "   📊 Argo CD Dashboard:  https://localhost:8080"
echo "   🔍 SonarQube:          http://localhost:9000"
echo ""
echo "🔑 Argo CD Login:"
echo "   Username: admin"
echo "   Password: $ARGO_PASSWORD"
echo ""
echo "💡 Tips:"
echo "   - In Codespaces, use the 'Ports' tab to make URLs public"
echo "   - SonarQube might take 2-3 minutes to start"
echo "   - Run 'pkill -f kubectl' to stop all port forwarding"
echo ""
echo "📊 Check deployment status:"
echo "   kubectl get applications -n argocd"
echo "   kubectl get pods -n sonarqube -w"

# Keep script running
echo ""
echo "Press Ctrl+C to stop port forwarding..."
wait