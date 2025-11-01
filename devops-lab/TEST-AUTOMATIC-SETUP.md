# 🧪 Testing Automatic Setup

This guide helps you test that the automatic setup works when creating a new Codespace.

## Step 1: Create a New Codespace

1. Go to your GitHub repository
2. Click the green **"Code"** button
3. Select **"Codespaces"** tab
4. Click **"Create codespace on main"**
5. Wait ~3-5 minutes for the Codespace to start

## Step 2: Check if Setup Script Ran Automatically

Once the Codespace opens, check the terminal output:

```bash
# Check terminal history to see if setup script ran
history | grep setup.sh

# Check if tools are already installed
terraform --version
helm version
checkov --version
yamllint --version
```

**If tools show version numbers**: ✅ Setup ran automatically!

**If tools show "command not found"**: ❌ Setup didn't run automatically (see troubleshooting below)

## Step 3: Run Verification Script

```bash
# From repository root
bash devops-lab/verify-setup.sh
```

This will show you:
- ✅ What's installed
- ❌ What's missing
- 📁 Project structure check

## Step 4: Test Each Tool

### Test Docker
```bash
docker ps
docker --version
docker compose version
```

### Test Terraform
```bash
cd devops-lab/terraform-local
terraform init
terraform version
cd ../..
```

### Test Helm
```bash
cd devops-lab/helm-learn
helm lint .
helm version
cd ../..
```

### Test Checkov
```bash
cd devops-lab
checkov -d terraform-local --quiet
checkov --version
cd ..
```

### Test yamllint
```bash
yamllint devops-lab/helm-learn/Chart.yaml
yamllint --version
```

### Test Aliases
```bash
# Reload shell first
source ~/.bashrc

# Test aliases
dc --version  # Should show docker compose version
tf version    # Should show terraform version
```

## Expected Results

After automatic setup, you should see:

✅ Docker: Installed (pre-installed in Codespaces)  
✅ Docker Compose: Installed (pre-installed in Codespaces)  
✅ Terraform: `Terraform v1.5.7` (or similar)  
✅ Helm: `v3.x.x` (or similar)  
✅ Checkov: `checkov x.x.x` (or similar)  
✅ yamllint: `yamllint x.x.x` (or similar)  
✅ Python 3: Installed  
✅ Aliases: Available after `source ~/.bashrc`

## Troubleshooting

### Setup didn't run automatically?

1. **Check if it's still running:**
   ```bash
   ps aux | grep setup.sh
   ```

2. **Manually run setup:**
   ```bash
   cd devops-lab
   bash .devcontainer/setup.sh
   ```

3. **Check for errors:**
   ```bash
   # Check if script is executable
   ls -la devops-lab/.devcontainer/setup.sh
   
   # Try running it manually to see errors
   cd devops-lab
   bash -x .devcontainer/setup.sh
   ```

4. **Check devcontainer.json:**
   ```bash
   cat devops-lab/.devcontainer/devcontainer.json | grep postCreateCommand
   ```

### Tools not found after setup?

1. **Reload your shell:**
   ```bash
   source ~/.bashrc
   ```

2. **Check if tools are in PATH:**
   ```bash
   which terraform
   which helm
   which checkov
   which yamllint
   ```

3. **Check installation locations:**
   ```bash
   /usr/local/bin/terraform --version
   /usr/local/bin/helm version
   ```

## Quick Test Script

Run this one-liner to test everything:

```bash
echo "Testing DevOps Lab Setup..." && \
docker --version && \
terraform --version && \
helm version && \
checkov --version && \
yamllint --version && \
echo "✅ All tools installed!" || echo "❌ Some tools missing - run setup.sh"
```

## Success Criteria

✅ All version commands return version numbers  
✅ Docker and Docker Compose work  
✅ Terraform can run `terraform init`  
✅ Helm can run `helm lint`  
✅ Checkov can scan Terraform files  
✅ yamllint can validate YAML files  
✅ Aliases work after reloading shell

---

**After testing, you're ready to use the lab!** 🎉

