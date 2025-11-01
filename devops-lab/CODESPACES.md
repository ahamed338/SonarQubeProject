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

### 3. Automatic Setup

When the Codespace starts, it automatically:
- ✅ Installs Docker and Docker Compose
- ✅ Installs Terraform
- ✅ Installs Helm
- ✅ Configures VS Code extensions
- ✅ Sets up helpful aliases

### 4. Verify Setup

```bash
# Check all tools are installed
docker --version
terraform version
helm version

# You should see all commands working!
```

## 🐳 Start SonarQube

```bash
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
- Run manually: `bash .devcontainer/setup.sh`

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

