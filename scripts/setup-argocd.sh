#!/bin/bash

set -e

echo "🚀 Setting up SonarQube with Argo CD in Codespaces..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Function to print status
print_status() {
    echo -e "${GREEN}✅${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠️${NC} $1"
}

print_error() {
    echo -e "${RED}❌${NC} $1"
}

# Check if kind is installed
if ! command -v kind &> /dev/null; then
    print_error "kind not found. Please run .devcontainer/setup.sh first"
    exit 1
fi

# Create Kubernetes cluster with kind
print_status "Creating Kubernetes cluster..."
kind create cluster --name sonarqube-argocd --config - <<EOF
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
  kubeadmConfigPatches:
  - |
    kind: InitConfiguration
    nodeRegistration:
      kubeletExtraArgs:
        node-labels: "ingress-ready=true"
  extraPortMappings:
  - containerPort: 30000
    hostPort: 9000
    protocol: TCP
  - containerPort: 30001
    hostPort: 8080
    protocol: TCP
EOF

# Install Argo CD
print_status "Installing Argo CD..."
kubectl create namespace argocd --dry-run=client -o yaml | kubectl apply -f -
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Wait for Argo CD to be ready
print_status "Waiting for Argo CD pods to be ready..."
kubectl wait --for=condition=ready pod -l app.kubernetes.io/name=argocd-server -n argocd --timeout=600s

# Get Argo CD password
ARGO_PASSWORD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)

# Deploy SonarQube application
print_status "Deploying SonarQube via Argo CD..."
kubectl apply -f kubernetes/argocd/applications.yaml

print_status "Setup complete! 🎉"
echo ""
echo "🌐 Access URLs:"
echo "   Argo CD UI: https://localhost:8080"
echo "   SonarQube:  http://localhost:9000"
echo ""
echo "🔑 Argo CD Credentials:"
echo "   Username: admin"
echo "   Password: $ARGO_PASSWORD"
echo ""
echo "📝 Next steps:"
echo "   1. Run: bash scripts/port-forward.sh"
echo "   2. Open Argo CD UI and check sync status"
echo "   3. Access SonarQube after deployment completes"