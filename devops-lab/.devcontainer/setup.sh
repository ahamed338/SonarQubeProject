#!/usr/bin/env bash
# Robust Setup Script for DevOps Learning Lab (Universal)
# Works in GitHub Codespaces, Ubuntu, WSL, or macOS without sudo binary issues
set -euo pipefail

echo "🚀 Setting up DevOps Learning Lab..."
echo ""

# ---------------------------------------------------------
# Detect Environment
# ---------------------------------------------------------
OS=$(uname | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)
if [[ "$ARCH" == "x86_64" ]]; then ARCH="amd64"; fi
if [[ "$ARCH" == "aarch64" ]]; then ARCH="arm64"; fi

# ---------------------------------------------------------
# Ensure Local Bin Directory
# ---------------------------------------------------------
mkdir -p "$HOME/bin"
export PATH="$HOME/bin:$PATH"
if ! grep -q 'export PATH="$HOME/bin:$PATH"' ~/.bashrc; then
  echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc
fi

# ---------------------------------------------------------
# Update Packages & Install Base Tools
# ---------------------------------------------------------
echo "📦 Updating package list..."
sudo apt-get update -qq

echo "🔧 Installing base utilities..."
sudo apt-get install -y -qq jq curl unzip tar wget git python3 python3-pip python3-venv ca-certificates vim nano

# ---------------------------------------------------------
# Install/Update Terraform
# ---------------------------------------------------------
echo "🧱 Installing/Updating Terraform (latest stable)..."
LATEST_TERRAFORM_VERSION=$(curl -fsS https://checkpoint-api.hashicorp.com/v1/check/terraform | jq -r .current_version)
TERRAFORM_ZIP="terraform_${LATEST_TERRAFORM_VERSION}_${OS}_${ARCH}.zip"
curl -fsSL "https://releases.hashicorp.com/terraform/${LATEST_TERRAFORM_VERSION}/${TERRAFORM_ZIP}" -o /tmp/terraform.zip
unzip -o -q /tmp/terraform.zip -d /tmp
mv /tmp/terraform "$HOME/bin/terraform"
chmod +x "$HOME/bin/terraform"
rm -f /tmp/terraform.zip
echo "    ✅ Terraform version: $(terraform version | head -n1)"

# ---------------------------------------------------------
# Install/Update Helm
# ---------------------------------------------------------
echo "⚓ Installing/Updating Helm..."
HELM_VERSION=$(curl -fsS https://api.github.com/repos/helm/helm/releases/latest | jq -r .tag_name)
curl -fsSL "https://get.helm.sh/helm-${HELM_VERSION}-${OS}-${ARCH}.tar.gz" -o /tmp/helm.tar.gz
tar -xzf /tmp/helm.tar.gz -C /tmp
mv /tmp/${OS}-${ARCH}/helm "$HOME/bin/helm"
chmod +x "$HOME/bin/helm"
rm -rf /tmp/helm* /tmp/${OS}-${ARCH}
echo "    ✅ Helm version: $(helm version --short)"

# ---------------------------------------------------------
# Verify Docker (non-fatal)
# ---------------------------------------------------------
echo "🐳 Checking Docker..."
if command -v docker >/dev/null 2>&1; then
  docker compose version 2>/dev/null || docker --version
else
  echo "    ⚠️ Docker not installed (non-fatal)"
fi

# ---------------------------------------------------------
# Install Checkov & yamllint
# ---------------------------------------------------------
echo "🛡️ Installing Checkov & yamllint..."
pip3 install --quiet --upgrade pip
pip3 install --quiet checkov yamllint
echo "    ✅ Checkov: $(checkov --version 2>/dev/null || python3 -m checkov --version)"
echo "    ✅ yamllint: $(yamllint --version 2>/dev/null || python3 -m yamllint --version)"

# ---------------------------------------------------------
# Setup Aliases
# ---------------------------------------------------------
echo "⚙️ Setting up aliases..."
cat >> ~/.bashrc << 'EOF'

# === DevOps Lab Aliases ===
alias ll='ls -alF'
alias dc='docker compose'
alias tf='terraform'
alias k='kubectl'
alias sonar-up='cd sonar-docker && docker compose up -d'
alias sonar-down='cd sonar-docker && docker compose down'
alias sonar-logs='cd sonar-docker && docker compose logs -f'

EOF

# ---------------------------------------------------------
# Final Verification
# ---------------------------------------------------------
echo ""
echo "✅ Setup Complete — Summary:"
terraform version | head -n1
helm version --short
checkov --version || true
yamllint --version || true
python3 --version
pip3 --version
echo ""
echo "📚 Next Steps:"
echo "  - Start SonarQube: cd sonar-docker && docker compose up -d"
echo "  - Run Terraform: cd terraform-local && terraform init && terraform plan"
echo "  - Lint YAML: yamllint ."
echo "  - Scan IaC: checkov -d ."
echo ""
echo "🎉 Done!"
