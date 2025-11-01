# DevOps Learning Lab 🚀

A hands-on self-learning project to understand **Kubernetes (conceptually)**, **Helm**, **Terraform**, and **SonarQube** without needing cloud access or a powerful laptop.

## 🎯 Project Goals

- **Learn by doing**: Hands-on experience with real DevOps tools
- **GitHub Codespaces Ready**: Optimized for cloud development environment (free tier available)
- **No cloud required**: Everything runs locally or in free GitHub Codespaces
- **Resource-friendly**: Lightweight containers work on any machine
- **Beginner-friendly**: Clear explanations at every step

## 📁 Project Structure

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
└── README.md
```

## 🚀 Quick Start with GitHub Codespaces

**Recommended**: This project is optimized for **GitHub Codespaces** - a free cloud development environment!

### Opening in Codespaces

1. **Push to GitHub**:
   ```bash
   git init
   git add .
   git commit -m "Initial commit: DevOps Learning Lab"
   git remote add origin https://github.com/YOUR_USERNAME/devops-lab.git
   git push -u origin main
   ```

2. **Open in Codespaces**:
   - Go to your GitHub repository
   - Click the green **"Code"** button
   - Select **"Codespaces"** tab
   - Click **"Create codespace on main"**
   - Wait for the environment to set up (auto-installs Docker, Terraform, Helm!)

3. **Everything is ready!**
   - Docker is pre-installed
   - Terraform is pre-installed
   - Helm is pre-installed
   - VS Code extensions are configured
   - Just start coding! 🎉

### Port Forwarding in Codespaces

- SonarQube (port 9000) is automatically forwarded
- Click the **Ports** tab in VS Code/Codespaces
- Click on port 9000 → **"Open in Browser"**
- Access SonarQube at the provided URL

## 🛠️ Local Setup (Alternative)

If you prefer running locally:

- **Docker Desktop** (for running containers)
- **VS Code** or **Cursor AI** (for editing files)
- **Git** (for version control)
- **Helm CLI**: `brew install helm` (to validate charts locally)
- **Terraform CLI**: `brew install terraform` (to run Terraform locally)

## 📚 Learning Path

### Step 1: Run SonarQube with Docker 🐳

**What you'll learn:**
- How containers work together
- Docker Compose for multi-container applications
- Networking between containers
- Persistent data volumes

**How to run:**

```bash
# Navigate to the SonarQube directory
cd sonar-docker

# Start SonarQube and PostgreSQL
docker compose up -d

# Check if containers are running
docker compose ps

# View logs
docker compose logs -f sonarqube

# Access SonarQube web interface
# In Codespaces: Check the Ports tab, click on port 9000 → "Open in Browser"
# Locally: Open browser: http://localhost:9000
# Default credentials: admin/admin (you'll be prompted to change)
```

**Understanding the setup:**
- `postgres`: Database container storing SonarQube data
- `sonarqube`: Application container analyzing code quality
- Containers communicate via Docker network (`sonar-network`)
- Data persists in Docker volumes (survives container restarts)

**Stop when done:**
```bash
docker compose down        # Stops containers (keeps data)
docker compose down -v     # Stops containers and removes volumes
```

**Note**: In Codespaces, Docker Compose V2 is used (`docker compose` not `docker-compose`)

**Learning questions:**
- Why do we need two containers?
- How does SonarQube connect to PostgreSQL?
- What happens to data when containers restart?

---

### Step 2: Learn Helm Templates Locally 📦

**What you'll learn:**
- Helm chart structure (package manager for Kubernetes)
- Template syntax (`{{ .Values.xxx }}`)
- How Kubernetes manifests are parameterized
- Separation of concerns (templates vs. values)

**What is Helm?**
- **Helm** is like `apt`/`yum` for Kubernetes
- Charts are packages containing Kubernetes manifests
- Templates + Values = Final Kubernetes resources
- Makes deploying complex apps easier

**How to explore:**

```bash
# Navigate to Helm chart directory
cd helm-learn

# In Codespaces, Helm is pre-installed:
helm lint .                    # Check for errors
helm template .                # See rendered YAML (what K8s would receive)
helm template . --debug        # Show intermediate template steps

# Or just read the files:
# - Chart.yaml: Chart metadata
# - values.yaml: Default configuration
# - templates/deployment.yaml: Kubernetes Deployment template
```

**File explanations:**

1. **`Chart.yaml`**: Metadata (name, version, description)
2. **`values.yaml`**: Default configuration values
3. **`templates/deployment.yaml`**: Kubernetes Deployment template

**How it works (conceptually):**
```
values.yaml → Templates → Rendered YAML → Kubernetes API
(settings)   ({{.Values}} syntax)  (final manifests)  (creates pods)
```

**Real-world analogy:**
- Think of Helm like a form letter template
- `values.yaml` = filling in name, address, etc.
- `templates/` = the letter template with blanks
- Result = personalized letter ready to send

**Learning questions:**
- How would you change the number of replicas?
- What happens if you modify `values.yaml`?
- How does Helm simplify Kubernetes deployments?

---

### Step 3: Practice Terraform Locally 🏗️

**What you'll learn:**
- Infrastructure as Code (IaC) concepts
- Terraform providers (local, docker, cloud providers)
- Declarative infrastructure management
- Terraform workflow (init, plan, apply, destroy)

**What is Terraform?**
- **Terraform** defines infrastructure in code
- Write what you want → Terraform creates it
- Works with cloud providers (AWS, GCP, Azure), Kubernetes, Docker, etc.
- Version control your infrastructure!

**How to run:**

```bash
# Navigate to Terraform directory
cd terraform-local

# In Codespaces, Terraform is pre-installed:
# Initialize Terraform (downloads providers)
terraform init

# Preview changes (dry run)
terraform plan

# Apply changes (creates resources)
terraform apply
# Type "yes" when prompted

# View outputs
terraform output

# Destroy resources when done
terraform destroy
```

**What this creates:**
- Local file: `output.txt` (demonstrates file management)
- Docker image: Pulls SonarQube image (simulates image management)
- Docker container: Creates a container (simulates infrastructure)

**Terraform workflow:**
```
1. terraform init    → Download providers
2. terraform plan    → Preview changes (safe, no changes made)
3. terraform apply   → Create/update resources
4. terraform destroy → Remove resources
```

**In real cloud scenarios:**
- Replace `docker` provider with `aws`, `google`, or `azurerm`
- Terraform would create:
  - Virtual machines (EC2, Compute Engine)
  - Databases (RDS, Cloud SQL)
  - Load balancers
  - Networks and security groups
  - Kubernetes clusters

**Learning questions:**
- How is Terraform different from manually clicking in cloud console?
- Why use `terraform plan` before `apply`?
- How does Terraform track what it created?

---

### Step 4: Security Scanning with Checkov 🔒

**What you'll learn:**
- Infrastructure as Code (IaC) security scanning
- Common security misconfigurations
- Compliance checking
- Automated security testing

**What is Checkov?**
- **Checkov** is a static code analysis tool for Infrastructure as Code
- Scans Terraform, Docker, Kubernetes, Helm, etc. for security issues
- Finds misconfigurations, vulnerabilities, and compliance violations
- Helps prevent security issues before deployment

**How to use:**

```bash
# In Codespaces, Checkov is pre-installed:
# Scan Terraform files
cd terraform-local
checkov -d . --framework terraform

# Scan Docker Compose files
cd sonar-docker
checkov -d . --framework docker_compose

# Scan Helm charts
cd helm-learn
checkov -d . --framework helm

# Scan everything
cd ..
checkov -d devops-lab

# Run with custom config
checkov -d . --config .checkov.yml
```

**What Checkov finds:**
- Hardcoded secrets in code
- Missing security best practices
- Compliance violations (PCI-DSS, HIPAA, etc.)
- Vulnerable container images
- Insecure network configurations

**Learning questions:**
- What security issues did Checkov find?
- How can you fix the issues?
- Why is security scanning important in DevOps?

---

### Step 5: Combine CI/CD with GitHub Actions ⚙️

**What you'll learn:**
- Continuous Integration (CI) concepts
- GitHub Actions workflows
- Automated testing and validation
- Pipeline stages and jobs

**What is CI/CD?**
- **CI (Continuous Integration)**: Automatically test code when pushed
- **CD (Continuous Deployment)**: Automatically deploy when tests pass
- **GitHub Actions**: Free CI/CD platform (included with GitHub)

**How to use:**

1. **Push code to GitHub:**
   ```bash
   git init
   git add .
   git commit -m "Initial commit: DevOps Learning Lab"
   git remote add origin https://github.com/YOUR_USERNAME/devops-lab.git
   git push -u origin main
   ```

2. **View workflow runs:**
   - Go to GitHub repository
   - Click "Actions" tab
   - See workflow runs in real-time

3. **Workflow does:**
   - ✅ Validates YAML files (docker-compose, Helm)
   - ✅ Formats and validates Terraform code
   - ✅ Simulates SonarQube code analysis
   - ✅ Provides summary

**Workflow breakdown:**

```yaml
Jobs run in parallel:
├── lint: Validate YAML files (with yamllint)
├── terraform: Validate Terraform code
├── security-scan: Security scanning with Checkov
├── sonarqube-scan: Code quality analysis
└── summary: Pipeline summary
```

**Real CI/CD pipeline stages:**
```
Code Push → Build → Test → Lint → Security Scan → Deploy to Staging → Deploy to Production
```

**Learning questions:**
- Why run tests automatically instead of manually?
- What happens if a test fails in CI?
- How would you add a deployment step?

---

## 🧠 Technology Concepts Explained

### Docker & Containers
- **Container**: Lightweight, isolated environment running an application
- **Docker Compose**: Tool to define and run multi-container apps
- **Volume**: Persistent storage that survives container restarts
- **Network**: Allows containers to communicate with each other

### Kubernetes (Conceptual)
- **Kubernetes (K8s)**: Container orchestration platform
- **Pod**: Smallest deployable unit (contains one or more containers)
- **Deployment**: Manages pod replicas, handles rolling updates
- **Service**: Exposes pods to network (like a load balancer)
- **We're simulating K8s** with Helm templates (no real cluster needed)

### Helm
- **Chart**: Package containing Kubernetes resources
- **Template**: Kubernetes YAML with placeholders (`{{ .Values.xxx }}`)
- **Values**: Configuration that fills templates
- **Release**: Instance of a chart deployed to Kubernetes

### Terraform
- **Provider**: Plugin that manages resources (AWS, Docker, local, etc.)
- **Resource**: Infrastructure component (file, container, server, etc.)
- **State**: Terraform tracks what it created (in `.tfstate` file)
- **Declarative**: You describe desired state, Terraform figures out how to get there

### CI/CD
- **Continuous Integration**: Merge code changes frequently, test automatically
- **Continuous Deployment**: Automatically deploy after tests pass
- **Pipeline**: Sequence of automated steps (build, test, deploy)
- **GitHub Actions**: Free CI/CD platform built into GitHub

---

## 🔧 Troubleshooting

### Docker Issues

**Problem**: Docker containers won't start
```bash
# In Codespaces: Docker is pre-configured, just ensure it's running
docker ps

# Check available memory
docker system df

# Remove unused resources
docker system prune
```

**Problem**: Port 9000 already in use (in Codespaces)
- In Codespaces, port forwarding is automatic
- Check the **Ports** tab in VS Code
- You can forward to a different port if needed
- Locally: Change port in docker-compose.yml: `ports: "9001:9000"`

### Terraform Issues

**Problem**: Provider download fails
```bash
# Check internet connection
# Terraform needs to download providers from registry
```

**Problem**: Docker provider can't connect
```bash
# Ensure Docker Desktop is running
docker ps
```

### GitHub Actions Issues

**Problem**: Workflow not running
- Check: Is code pushed to GitHub?
- Check: Is workflow file in `.github/workflows/`?
- Check: Are you on `main` or `master` branch?

---

## 📖 Additional Learning Resources

- **Docker**: [Docker Official Docs](https://docs.docker.com/)
- **Kubernetes**: [Kubernetes Basics](https://kubernetes.io/docs/tutorials/kubernetes-basics/)
- **Helm**: [Helm Documentation](https://helm.sh/docs/)
- **Terraform**: [Terraform Learn](https://learn.hashicorp.com/terraform)
- **GitHub Actions**: [GitHub Actions Docs](https://docs.github.com/en/actions)

---

## 🎓 Next Steps

After completing this lab:

1. **Extend SonarQube**: Analyze a real code project
2. **Customize Helm Chart**: Add more templates (Service, ConfigMap)
3. **Terraform Cloud**: Try Terraform Cloud (free tier) for remote state
4. **Real K8s**: Use [minikube](https://minikube.sigs.k8s.io/) or [kind](https://kind.sigs.k8s.io/) for local K8s cluster
5. **Codespaces Features**: 
   - Use port forwarding to access services
   - Install additional tools via the setup script
   - Commit and push changes to trigger CI/CD workflows

---

## 📝 License

This is a learning project. Feel free to use and modify as needed.

---

## 🙏 Credits

Created for hands-on DevOps learning without cloud dependencies.

**Happy Learning!** 🚀

