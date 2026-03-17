# Cloud-AKS Platform

Enterprise Azure infrastructure platform with AKS, Terraform IaC and Python monitoring dashboard.

## Architecture
```
Internet → Application Gateway → AKS Cluster → Python Flask App
                                      │
                              Azure Container Registry
                                      │
                              Azure Monitor + Log Analytics
```

## Stack

| Layer | Technology |
|-------|-----------|
| IaC | Terraform (modular) |
| Orchestration | Azure Kubernetes Service |
| Container Registry | Azure Container Registry |
| App | Python Flask + Chart.js |
| CI/CD | GitHub Actions |
| Security | Zero Trust + Private Endpoints |
| Monitoring | Azure Monitor + Log Analytics |

## Project Structure
```
cloud-aks-platform/
├── .github/workflows/    # CI/CD pipelines
├── infra/               # Terraform IaC
│   └── modules/
│       ├── networking/  # VNet, NSGs, Log Analytics
│       ├── security/    # RBAC, Key Vault
│       ├── acr/         # Container Registry
│       └── aks/         # Kubernetes cluster
├── app/                 # Python Flask dashboard
├── k8s/                 # Kubernetes manifests
└── docs/                # Architecture documentation
```

## Author

**Carlos Amador López**  
Azure Hybrid Cloud Specialist | Fortinet FCA | AZ-104 