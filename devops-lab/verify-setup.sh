#!/bin/bash
# Verification script for DevOps Lab setup
# Run this after running the setup script to verify all tools are installed correctly

echo "🔍 Verifying DevOps Learning Lab Setup..."
echo "=========================================="
echo ""

# Check Docker
echo "📦 Checking Docker..."
if command -v docker &> /dev/null; then
    DOCKER_VERSION=$(docker --version)
    echo "✅ Docker installed: $DOCKER_VERSION"
else
    echo "❌ Docker not found"
fi

# Check Docker Compose
echo ""
echo "🐳 Checking Docker Compose..."
if command -v docker &> /dev/null && docker compose version &> /dev/null; then
    COMPOSE_VERSION=$(docker compose version)
    echo "✅ Docker Compose installed: $COMPOSE_VERSION"
elif command -v docker-compose &> /dev/null; then
    COMPOSE_VERSION=$(docker-compose --version)
    echo "✅ Docker Compose installed: $COMPOSE_VERSION"
else
    echo "❌ Docker Compose not found"
fi

# Check Terraform
echo ""
echo "🏗️  Checking Terraform..."
if command -v terraform &> /dev/null; then
    TF_VERSION=$(terraform version | head -n 1)
    echo "✅ Terraform installed: $TF_VERSION"
else
    echo "❌ Terraform not found"
fi

# Check Helm
echo ""
echo "📦 Checking Helm..."
if command -v helm &> /dev/null; then
    HELM_VERSION=$(helm version --short)
    echo "✅ Helm installed: $HELM_VERSION"
else
    echo "❌ Helm not found"
fi

# Check Checkov
echo ""
echo "🔒 Checking Checkov..."
if command -v checkov &> /dev/null; then
    CHECKOV_VERSION=$(checkov --version | head -n 1)
    echo "✅ Checkov installed: $CHECKOV_VERSION"
else
    echo "❌ Checkov not found"
fi

# Check yamllint
echo ""
echo "📝 Checking yamllint..."
if command -v yamllint &> /dev/null; then
    YAMLLINT_VERSION=$(yamllint --version)
    echo "✅ yamllint installed: $YAMLLINT_VERSION"
else
    echo "❌ yamllint not found"
fi

# Check Python
echo ""
echo "🐍 Checking Python..."
if command -v python3 &> /dev/null; then
    PYTHON_VERSION=$(python3 --version)
    echo "✅ Python installed: $PYTHON_VERSION"
else
    echo "❌ Python not found"
fi

# Check Git
echo ""
echo "📚 Checking Git..."
if command -v git &> /dev/null; then
    GIT_VERSION=$(git --version)
    echo "✅ Git installed: $GIT_VERSION"
else
    echo "❌ Git not found"
fi

# Check project structure
echo ""
echo "📁 Checking project structure..."
if [ -d "devops-lab" ]; then
    echo "✅ devops-lab directory exists"
    
    if [ -f "devops-lab/sonar-docker/docker-compose.yml" ]; then
        echo "✅ docker-compose.yml found"
    else
        echo "❌ docker-compose.yml not found"
    fi
    
    if [ -f "devops-lab/helm-learn/Chart.yaml" ]; then
        echo "✅ Helm chart found"
    else
        echo "❌ Helm chart not found"
    fi
    
    if [ -f "devops-lab/terraform-local/main.tf" ]; then
        echo "✅ Terraform files found"
    else
        echo "❌ Terraform files not found"
    fi
else
    echo "⚠️  devops-lab directory not found (you may need to cd into it)"
fi

# Check aliases
echo ""
echo "⚡ Checking aliases..."
if grep -q "sonar-up" ~/.bashrc 2>/dev/null; then
    echo "✅ Aliases configured (sonar-up, sonar-down, etc.)"
    echo "   Run 'source ~/.bashrc' to load them"
else
    echo "⚠️  Aliases not found in .bashrc"
    echo "   Run setup script to add aliases"
fi

echo ""
echo "=========================================="
echo "✅ Verification complete!"
echo ""
echo "💡 If any tools are missing, run:"
echo "   cd devops-lab && bash .devcontainer/setup.sh"
echo ""
echo "💡 After running setup, reload your shell:"
echo "   source ~/.bashrc"
echo ""

