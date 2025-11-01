# DevOps Learning Lab 🚀

A hands-on self-learning project to understand **Kubernetes (conceptually)**, **Helm**, **Terraform**, and **SonarQube**. Optimized for **GitHub Codespaces** - run everything in the cloud with zero local setup!

## 📁 Project Structure

This repository contains a comprehensive DevOps learning lab:

```
devops-lab/
├── .devcontainer/         # GitHub Codespaces configuration
│   ├── devcontainer.json  # Codespaces setup config
│   └── setup.sh          # Auto-install script
├── sonar-docker/          # SonarQube + PostgreSQL via Docker Compose
│   └── docker-compose.yml
├── helm-learn/            # Helm chart examples (simulated)
│   ├── Chart.yaml
│   ├── values.yaml
│   └── templates/
│       └── deployment.yaml
├── terraform-local/       # Terraform local/Docker demo
│   └── main.tf
├── .github/workflows/     # GitHub Actions CI/CD
│   └── ci.yml
├── .checkov.yml          # Checkov security scanning config
├── .yamllint.yml         # YAML linting configuration
└── CODESPACES.md         # Quick Codespaces guide
```

## 🚀 Quick Start (GitHub Codespaces)

This project is optimized for **GitHub Codespaces** - everything runs in the cloud with zero local setup!

### Getting Started

1. Click the green **"Code"** button in this repository
2. Select the **"Codespaces"** tab
3. Click **"Create codespace on main"**
4. Wait ~3-5 minutes for the Codespace to start and automatically set up
   - The setup script runs automatically in the background
   - It installs Docker, Terraform, Helm, Checkov, and yamllint
5. After Codespace starts, reload your shell: `source ~/.bashrc`
6. Verify tools are installed: `bash devops-lab/verify-setup.sh`

### Your First Steps (in Codespaces)

**The setup script runs automatically when your Codespace starts!** Wait ~3-5 minutes for setup to complete.

If setup doesn't run automatically (or you want to run it again), manually run:
```bash
cd devops-lab
bash .devcontainer/setup.sh
```

After setup completes, reload your shell:
```bash
source ~/.bashrc
```

**Now you're ready! Try these commands:**

```bash
# Navigate to the devops-lab directory first
cd devops-lab

# 1. Start SonarQube
cd sonar-docker
docker compose up -d

# 2. Access SonarQube (check the Ports tab → port 9000 → Open in Browser)
# Default credentials: admin/admin

# 3. Explore Helm charts
cd ../helm-learn
helm template .

# 4. Run Terraform
cd ../terraform-local
terraform init
terraform plan

# 5. Security scanning (from devops-lab directory)
cd ..
checkov -d .
yamllint .
```

See [CODESPACES.md](./devops-lab/CODESPACES.md) for detailed instructions and troubleshooting.

**Verify Setup**: After your Codespace starts, verify tools are installed:
```bash
# Use the verification script
bash devops-lab/verify-setup.sh

# Or check manually
terraform --version
helm version
checkov --version
yamllint --version
```

If tools aren't installed, the setup script may still be running (wait 2-3 more minutes), or run it manually:
```bash
cd devops-lab && bash .devcontainer/setup.sh
```

### Alternative: Local Setup (Optional)

If you prefer to run locally, you'll need to install:
- Docker Desktop
- Terraform CLI: `brew install terraform`
- Helm CLI: `brew install helm`
- Python 3 (for Checkov and yamllint): `brew install python3`

Then follow the same commands above in your local terminal.

## 📚 Learning Path

1. **Step 1: Run SonarQube with Docker** - Learn containers and Docker Compose
2. **Step 2: Learn Helm Templates** - Understand Kubernetes package management
3. **Step 3: Practice Terraform** - Infrastructure as Code basics
4. **Step 4: Security Scanning with Checkov** - IaC security scanning
5. **Step 5: Combine CI/CD with GitHub Actions** - Automated pipelines

See the [Codespaces Guide](./devops-lab/CODESPACES.md) for complete learning instructions.

## 🛠️ Tools Included

- **Docker & Docker Compose** - Container orchestration
- **Terraform** - Infrastructure as Code
- **Helm** - Kubernetes package manager
- **SonarQube** - Code quality analysis
- **Checkov** - Security scanning for IaC
- **yamllint** - YAML file validation
- **GitHub Actions** - CI/CD automation

## 🔒 Security Scanning

This project includes automated security scanning:

- **Checkov**: Scans Terraform, Docker, Kubernetes, and Helm for security issues
- **yamllint**: Validates YAML syntax and style
- Both tools run automatically in CI/CD pipeline

## 📖 Documentation

- **[Codespaces Guide](./devops-lab/CODESPACES.md)** - Quick start for GitHub Codespaces

## 🎯 Project Goals

- **Learn by doing**: Hands-on experience with real DevOps tools
- **GitHub Codespaces Optimized**: Zero local setup - everything runs in the cloud
- **Free tier available**: 60 hours/month of Codespaces for personal accounts
- **Resource-friendly**: Lightweight containers work on any machine
- **Beginner-friendly**: Clear explanations at every step

## 📝 License

This is a learning project. Feel free to use and modify as needed.

---

**Happy Learning!** 🎉

