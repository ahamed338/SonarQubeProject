#!/bin/bash

set -e

echo "🚀 Setting up SonarQube with Argo CD using Minikube..."

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

print_status() {
    echo -e "${GREEN}✅${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠️${NC} $1"
}

# Start minikube if not running
if ! minikube status | grep -q "Running"; then
    print_status "Starting Minikube..."
    minikube start --driver=docker --force
fi

# Install Argo CD
print_status "Installing Argo CD..."
kubectl create namespace argocd --dry-run=client -o yaml | kubectl apply -f -
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Wait for Argo CD
print_status "Waiting for Argo CD to be ready..."
sleep 30
kubectl wait --for=condition=ready pod -l app.kubernetes.io/name=argocd-server -n argocd --timeout=600s

# Get Argo CD password
ARGO_PASSWORD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)

# Add SonarQube Helm repository
print_status "Adding SonarQube Helm repository..."
helm repo add oteemo https://oteemo.github.io/charts
helm repo update

# Deploy SonarQube application
print_status "Deploying SonarQube via Argo CD..."
kubectl apply -f kubernetes/argocd/applications.yaml

print_status "Setup complete! 🎉"
echo ""
echo "🌐 Access URLs:"
echo "   Argo CD UI:  https://localhost:8080"
echo "   SonarQube:   http://localhost:9000"
echo ""
echo "🔑 Argo CD Credentials:"
echo "   Username: admin"
echo "   Password: $ARGO_PASSWORD"
echo ""
echo "📝 Next steps:"
echo "   1. Run: bash scripts/port-forward-minikube.sh"
echo "   2. Check Argo CD UI for sync status"