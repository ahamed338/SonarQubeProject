#!/bin/bash
# Setup script for GitHub Codespaces
# This script installs all necessary tools and prepares the environment

set -e

echo "🚀 Setting up DevOps Learning Lab in GitHub Codespaces..."
echo ""

# Update package list
echo "📦 Updating package list..."
sudo apt-get update -qq

# Install required tools
echo "🔧 Installing tools..."

# Install Terraform
echo "  → Installing Terraform..."
TERRAFORM_VERSION="1.5.7"
TERRAFORM_ZIP="terraform_${TERRAFORM_VERSION}_linux_amd64.zip"
curl -fsSL "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/${TERRAFORM_ZIP}" -o /tmp/terraform.zip
sudo unzip -q /tmp/terraform.zip -d /usr/local/bin/
sudo chmod +x /usr/local/bin/terraform
rm /tmp/terraform.zip
terraform version

# Install Helm
echo "  → Installing Helm..."
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
helm version

# Install Docker Compose CLI (usually already installed with Docker)
echo "  → Verifying Docker Compose..."
docker compose version || docker-compose version

# Install Python and pip (needed for Checkov and yamllint)
echo "  → Installing Python..."
sudo apt-get install -y -qq \
  python3 \
  python3-pip \
  python3-venv

# Install Checkov (security scanning for IaC)
echo "  → Installing Checkov (security scanner)..."
pip3 install --quiet checkov
checkov --version

# Install yamllint (YAML linting tool)
echo "  → Installing yamllint..."
pip3 install --quiet yamllint
yamllint --version

# Install additional useful tools
echo "  → Installing additional tools..."
sudo apt-get install -y -qq \
  jq \
  curl \
  wget \
  git \
  unzip \
  vim \
  nano

# Create helpful aliases
echo "  → Setting up aliases..."
cat >> ~/.bashrc << 'EOF'

# DevOps Lab Aliases
alias ll='ls -alF'
alias dc='docker compose'
alias tf='terraform'
alias k='kubectl'

# Quick commands (works in Codespaces with any workspace folder name)
alias sonar-up='cd sonar-docker && docker compose up -d'
alias sonar-down='cd sonar-docker && docker compose down'
alias sonar-logs='cd sonar-docker && docker compose logs -f'

EOF

# Verify installations
echo ""
echo "✅ Setup complete! Installed tools:"
echo ""
terraform version
helm version
docker --version
docker compose version || docker-compose version
checkov --version
yamllint --version

echo ""
echo "📚 Next steps:"
echo "  1. Start SonarQube: cd sonar-docker && docker compose up -d"
echo "  2. Access SonarQube: Check the 'Ports' tab → port 9000 → 'Open in Browser'"
echo "  3. Explore Helm: cd helm-learn && helm template ."
echo "  4. Run Terraform: cd terraform-local && terraform init && terraform plan"
echo ""
echo "💡 Helpful aliases available:"
echo "  - sonar-up: Start SonarQube"
echo "  - sonar-down: Stop SonarQube"
echo "  - sonar-logs: View SonarQube logs"
echo ""
echo "🔒 Security Tools Installed:"
echo "  - Checkov: Security scanning for IaC"
echo "    Run: checkov -d terraform-local"
echo "    Run: checkov -d sonar-docker"
echo "  - yamllint: YAML file linting"
echo "    Run: yamllint ."
echo ""
echo "🎉 Your DevOps Learning Lab is ready!"

