#!/usr/bin/env bash
set -euo pipefail

echo "🔍 Verifying DevOps Learning Lab Setup..."
echo "=========================================="
echo ""

export PATH="$HOME/bin:$PATH"

check() {
  local name=$1
  local cmd=$2
  local version_arg=${3:-"--version"}

  if command -v "$cmd" >/dev/null 2>&1; then
    echo "✅ $name: $($cmd $version_arg 2>/dev/null | head -n1)"
  else
    echo "❌ $name: Not Installed"
  fi
}

check "Terraform" terraform
check "Helm" helm
check "Docker" docker "--version"
check "Python3" python3 "--version"
check "pip3" pip3 "--version"
check "Checkov" checkov "--version"
check "yamllint" yamllint "--version"
check "Git" git "--version"
check "curl" curl "--version"
check "jq" jq "--version"

echo ""
echo "✅ Verification complete!"
echo "If any tool is missing, re-run ./setup.sh"
