# 🚀 Quick Start: GitHub Codespaces

This guide will help you get started with the DevOps Learning Lab in GitHub Codespaces.

## 📋 Step-by-Step Setup

### 1. Push to GitHub

```bash
git init
git add .
git commit -m "Initial commit: DevOps Learning Lab"
git remote add origin https://github.com/YOUR_USERNAME/devops-lab.git
git push -u origin main
```

### 2. Create Codespace

1. Go to your GitHub repository
2. Click the green **"Code"** button
3. Select the **"Codespaces"** tab
4. Click **"Create codespace on main"**
5. Wait ~2-3 minutes for environment setup

### 3. Run Setup Script

**Important**: You must manually run the setup script to install all tools.

```bash
# Navigate to devops-lab directory
cd devops-lab

# Run the setup script
bash .devcontainer/setup.sh
```

This will install:
- ✅ Docker and Docker Compose (usually pre-installed in Codespaces)
- ✅ Terraform
- ✅ Helm
- ✅ Checkov (security scanner)
- ✅ yamllint (YAML linter)
- ✅ Helpful aliases

Wait ~2-3 minutes for setup to complete.

### 4. Verify Setup

After setup completes, reload your shell and verify tools are installed:

```bash
# Reload your shell environment
source ~/.bashrc

# Quick manual check
docker --version
terraform --version
helm version
checkov --version
yamllint --version
```

**Or use the verification script:**

```bash
# Run the verification script (from repository root)
bash devops-lab/verify-setup.sh
```

This will check all prerequisites and show you what's installed and what's missing.

## 🐳 Start SonarQube

```bash
# Navigate to devops-lab directory first (if not already there)
cd devops-lab

# Navigate to SonarQube directory
cd sonar-docker

# Start services
docker compose up -d

# Check status
docker compose ps

# View logs
docker compose logs -f sonarqube
```

## 🌐 Access SonarQube

1. **Open Ports Tab**: Click the **"Ports"** tab in VS Code bottom panel
2. **Find Port 9000**: Look for port 9000 (SonarQube)
3. **Open in Browser**: Click the globe icon → **"Open in Browser"**
4. **Login**: Use `admin/admin` (you'll be prompted to change)

## 📦 Explore Helm Charts

```bash
# Navigate to devops-lab directory first (if not already there)
cd devops-lab

# Navigate to Helm chart directory
cd helm-learn

# Validate chart
helm lint .

# See rendered YAML
helm template .

# Debug mode
helm template . --debug
```

## 🏗️ Run Terraform

```bash
# Navigate to devops-lab directory first (if not already there)
cd devops-lab

# Navigate to Terraform directory
cd terraform-local

# Initialize
terraform init

# Preview changes
terraform plan

# Apply (creates resources)
terraform apply

# Destroy when done
terraform destroy
```

## ⚡ Quick Aliases

The setup script creates helpful aliases:

```bash
sonar-up      # Start SonarQube
sonar-down    # Stop SonarQube
sonar-logs    # View SonarQube logs
dc            # docker compose
tf            # terraform
```

## 🔄 Trigger CI/CD

Push changes to GitHub to trigger the CI/CD pipeline:

```bash
# Make a change
echo "# Test" >> README.md

# Commit and push
git add .
git commit -m "Test CI/CD pipeline"
git push

# Check Actions tab in GitHub to see workflow run!
```

## 💡 Tips for Codespaces

1. **Port Forwarding**: Automatically configured for ports 9000 and 5432
2. **Auto-save**: Files save automatically
3. **Terminal**: Multiple terminal tabs available
4. **Extensions**: Pre-installed for Terraform, Docker, YAML
5. **Free Tier**: 60 hours/month free for personal accounts

## 🆘 Troubleshooting

**Port not accessible?**
- Check the **Ports** tab in VS Code
- Make sure port 9000 is set to **Public** or **Private**

**Docker commands not working?**
- Restart the Codespace: Codespaces → **Rebuild Container**

**Setup script didn't run?**
- The setup script must be run manually first
- Run: `cd devops-lab && bash .devcontainer/setup.sh`
- Wait for script to complete (~2-3 minutes)
- After completion, run: `source ~/.bashrc` to reload your shell

**Commands not found (terraform, helm, checkov, yamllint)?**
- You need to run the setup script first: `bash devops-lab/.devcontainer/setup.sh`
- Wait for script to complete (~2-3 minutes)
- After setup completes, run: `source ~/.bashrc` to reload your shell
- Then verify tools are installed with version commands

**Need more resources?**
- Codespaces automatically scales based on usage
- Free tier: 2-core machine, 4GB RAM (perfect for this lab!)

## 📚 Next Steps

1. ✅ Start SonarQube and analyze code
2. ✅ Customize Helm chart templates
3. ✅ Extend Terraform configuration
4. ✅ Modify CI/CD workflow
5. ✅ Read the main [README.md](./README.md) for detailed explanations

---

**Happy Learning!** 🎉

