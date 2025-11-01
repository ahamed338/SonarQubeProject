# 🚀 Quick Start Commands

After creating a new Codespace, follow these steps:

## Step 1: Run Setup Script

```bash
cd devops-lab
bash .devcontainer/setup.sh
```

Wait ~2-3 minutes for setup to complete.

## Step 2: Reload Shell

```bash
source ~/.bashrc
```

## Step 3: Verify All Tools

**Option A: Run verification script (recommended)**
```bash
# From repository root
bash devops-lab/verify-setup.sh
```

**Option B: Manual check**
```bash
docker --version
terraform --version
helm version
checkov --version
yamllint --version
```

All commands should show version numbers. If any show "command not found", re-run the setup script.

## Step 4: Test Everything Works

```bash
# Navigate to devops-lab
cd devops-lab

# Test Docker
docker ps

# Test Terraform
cd terraform-local
terraform init

# Test Helm
cd ../helm-learn
helm lint .

# Test Checkov
cd ..
checkov -d terraform-local --quiet

# Test yamllint
yamllint helm-learn/Chart.yaml
```

## Quick Reference: What Should Be Installed

- ✅ Docker (pre-installed in Codespaces)
- ✅ Docker Compose (pre-installed in Codespaces)
- ✅ Terraform (installed by setup.sh)
- ✅ Helm (installed by setup.sh)
- ✅ Checkov (installed by setup.sh)
- ✅ yamllint (installed by setup.sh)
- ✅ Python 3 (installed by setup.sh)

## Troubleshooting

**If verification fails:**
1. Make sure you ran the setup script: `cd devops-lab && bash .devcontainer/setup.sh`
2. Make sure setup completed (wait 2-3 minutes)
3. Reload shell: `source ~/.bashrc`
4. Run verification again: `bash devops-lab/verify-setup.sh`

**If tools still not found:**
- Check if setup script ran successfully
- Try running setup script again: `cd devops-lab && bash .devcontainer/setup.sh`
- Check setup script output for errors

