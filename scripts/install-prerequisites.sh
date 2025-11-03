#!/bin/bash

set -e

echo "🔧 Installing prerequisites for Argo CD and SonarQube..."

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

print_status() {
    echo -e "${GREEN}✅${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠️${NC} $1"
}

# Update package list
print_status "Updating package list..."
sudo apt-get update

# Install basic dependencies
print_status "Installing basic dependencies..."
sudo apt-get install -y \
    curl \
    wget \
    git \
    vim \
    nano \
    net-tools

# Install Docker
print_status "Installing Docker..."
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER

# Install kubectl
print_status "Installing kubectl..."
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm kubectl

# Install kind
print_status "Installing kind..."
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/

# Install Helm
print_status "Installing Helm..."
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Install Argo CD CLI
print_status "Installing Argo CD CLI..."
VERSION=$(curl --silent "https://api.github.com/repos/argoproj/argo-cd/releases/latest" | grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/')
curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
rm argocd-linux-amd64

# Make scripts executable
chmod +x scripts/*.sh

print_status "Prerequisites installation complete! 🎉"
echo ""
echo "🚀 Next steps:"
echo "   1. Logout and login again for group changes (or start new terminal)"
echo "   2. Run: bash scripts/setup-argocd.sh"
echo "   3. Then run: bash scripts/port-forward.sh"