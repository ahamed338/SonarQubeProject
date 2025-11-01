# DevOps Learning Lab 🚀

A hands-on self-learning project to understand **Kubernetes (conceptually)**, **Helm**, **Terraform**, and **SonarQube** without needing cloud access or a powerful laptop.

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

## 🚀 Quick Start

### GitHub Codespaces (Recommended)

1. Click the green **"Code"** button
2. Select **"Codespaces"** tab
3. Click **"Create codespace on main"**
4. Wait ~2-3 minutes for automatic setup
5. Everything is ready! Docker, Terraform, Helm, Checkov, and yamllint are pre-installed.

See [CODESPACES.md](./devops-lab/CODESPACES.md) for detailed Codespaces instructions.

### Local Setup

1. **Prerequisites:**
   - Docker Desktop
   - Terraform CLI: `brew install terraform`
   - Helm CLI: `brew install helm`
   - Python 3 (for Checkov and yamllint)

2. **Start SonarQube:**
   ```bash
   cd devops-lab/sonar-docker
   docker compose up -d
   # Access at http://localhost:9000 (default: admin/admin)
   ```

3. **Explore Helm:**
   ```bash
   cd devops-lab/helm-learn
   helm template .
   ```

4. **Run Terraform:**
   ```bash
   cd devops-lab/terraform-local
   terraform init
   terraform plan
   ```

5. **Security Scanning:**
   ```bash
   checkov -d devops-lab
   yamllint devops-lab
   ```

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
- **GitHub Codespaces Ready**: Optimized for cloud development environment
- **No cloud required**: Everything runs locally or in free GitHub Codespaces
- **Resource-friendly**: Lightweight containers work on any machine
- **Beginner-friendly**: Clear explanations at every step

## 📝 License

This is a learning project. Feel free to use and modify as needed.

---

**Happy Learning!** 🎉

