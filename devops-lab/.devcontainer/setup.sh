#!/bin/bash
# Robust Setup script for GitHub Codespaces
# Installs Terraform (latest), Helm (latest stable), Python tooling, Checkov, yamllint, and useful utilities.
set -euo pipefail

echo "🚀 Setting up DevOps Learning Lab in GitHub Codespaces..."
echo ""

# Update package list
echo "📦 Updating package list..."
sudo apt-get update -qq

# Install base utilities early (jq used to detect latest Terraform)
echo "🔧 Installing base packages (jq, curl, unzip, ca-certificates)..."
sudo apt-get install -y -qq jq curl unzip ca-certificates

# -------------------------
# Install/Update Terraform
# -------------------------
echo "  → Installing/Updating Terraform (latest stable)..."
LATEST_TERRAFORM_VERSION=$(curl -fsS https://checkpoint-api.hashicorp.com/v1/check/terraform | jq -r .current_version)
echo "    - latest terraform: ${LATEST_TERRAFORM_VERSION}"

TERRAFORM_ZIP="terraform_${LATEST_TERRAFORM_VERSION}_linux_amd64.zip"
TMP_TF="/tmp/${TERRAFORM_ZIP}"

curl -fsSL "https://releases.hashicorp.com/terraform/${LATEST_TERRAFORM_VERSION}/${TERRAFORM_ZIP}" -o "${TMP_TF}"
sudo unzip -o -q "${TMP_TF}" -d /usr/local/bin/
sudo chmod +x /usr/local/bin/terraform
rm -f "${TMP_TF}"
echo "    - terraform version: $(/usr/local/bin/terraform version | head -n1)"

# -------------------------
# Install/Update Helm
# -------------------------
echo "  → Installing/Updating Helm (latest stable)..."
HELM_VERSION="v3.19.0" # fallback; we'll try to detect latest from get.helm.sh comments, but pin if you prefer
# Download directly from get.helm.sh metadata (we fall back to pinned version above if detection fails)
# Safer to fetch explicit release — here we try to get latest by checking GitHub API (quietly)
if LATEST_HELM_TAG=$(curl -fsS https://api.github.com/repos/helm/helm/releases/latest | jq -r .tag_name 2>/dev/null); then
  HELM_VERSION="${LATEST_HELM_TAG}"
fi

echo "    - installing helm ${HELM_VERSION}"
HELM_TAR="helm-${HELM_VERSION}-linux-amd64.tar.gz"
TMP_HELM="/tmp/${HELM_TAR}"
curl -fsSL "https://get.helm.sh/${HELM_TAR}" -o "${TMP_HELM}"
tar -xzf "${TMP_HELM}" -C /tmp
if [ -f /tmp/linux-amd64/helm ]; then
  sudo rm -f /usr/local/bin/helm || true
  sudo mv /tmp/linux-amd64/helm /usr/local/bin/helm
  sudo chmod +x /usr/local/bin/helm
  rm -rf /tmp/linux-amd64
  rm -f "${TMP_HELM}"
  echo "    - helm version: $(/usr/local/bin/helm version --short 2>/dev/null || true)"
else
  echo "    ⚠️  Failed to extract helm binary; falling back to official installer script."
  curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 -o /tmp/get_helm.sh
  chmod +x /tmp/get_helm.sh
  sudo /tmp/get_helm.sh
  rm -f /tmp/get_helm.sh
  echo "    - helm version: $(/usr/local/bin/helm version --short 2>/dev/null || true)"
fi

# -------------------------
# Verify Docker Compose (non-fatal)
# -------------------------
echo "  → Verifying Docker Compose..."
if command -v docker >/dev/null 2>&1; then
  docker compose version 2>/dev/null || docker-compose version 2>/dev/null || echo "    - docker compose not available / non-fatal"
else
  echo "    - docker not installed (non-fatal for this script)"
fi

# -------------------------
# Install Python & pip & venv
# -------------------------
echo "  → Installing Python3, pip, venv..."
sudo apt-get install -y -qq python3 python3-pip python3-venv

# Upgrade pip quietly
echo "  → Upgrading pip..."
pip3 install --quiet --upgrade pip

# -------------------------
# Install Checkov and yamllint
# -------------------------
echo "  → Installing security & linting tools (checkov, yamllint)..."
pip3 install --quiet checkov yamllint
# ensure binary links available from /usr/local/bin (pip usually puts in ~/.local/bin; add to PATH if needed)
# but we will verify by calling modules via python -m if binaries aren't on PATH

# Try to get versions (use full path or python -m fallback)
echo "    - checkov version: $(command -v checkov >/dev/null 2>&1 && checkov --version || python3 -c 'import pkgutil,sys;print(__import__(\"pkg_resources\").get_distribution(\"checkov\").version)')"
echo "    - yamllint version: $(command -v yamllint >/dev/null 2>&1 && yamllint --version || python3 -c 'import pkgutil,sys;print(__import__(\"pkg_resources\").get_distribution(\"yamllint\").version)')"

# -------------------------
# Additional useful tools
# -------------------------
echo "  → Installing additional useful packages (jq already installed)..."
sudo apt-get install -y -qq \
  curl \
  wget \
  git \
  unzip \
  vim \
  nano

# -------------------------
# Aliases
# -------------------------
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

# -------------------------
# Final verification summary
# -------------------------
echo ""
echo "✅ Setup finished — summary:"
echo ""
if command -v terraform >/dev/null 2>&1; then
  terraform version | head -n1
else
  echo "terraform: not found"
fi

if command -v helm >/dev/null 2>&1; then
  helm version --short || echo "helm: installed but version check failed"
else
  echo "helm: not found"
fi

if command -v docker >/dev/null 2>&1; then
  docker --version
fi

# Check checkov / yamllint
if command -v checkov >/dev/null 2>&1; then
  checkov --version || true
else
  python3 -c "import pkg_resources as p; print('checkov:', p.get_distribution('checkov').version)" || true
fi

if command -v yamllint >/dev/null 2>&1; then
  yamllint --version || true
else
  python3 -c "import pkg_resources as p; print('yamllint:', p.get_distribution('yamllint').version)" || true
fi

echo ""
echo "📚 Next steps:"
echo "  - Start SonarQube: cd sonar-docker && docker compose up -d"
echo "  - Run terraform: cd terraform-local && terraform init && terraform plan"
echo "  - Lint YAML: yamllint ."
echo "  - Scan IaC: checkov -d ."
echo ""
echo "🎉 Done!"
