### DevOps Intern Project – AutoGCP: Simple GCP Project Creation via YAML

This repository contains a Terraform + Python setup to provision Google Cloud resources. It has been updated to support the AutoGCP mini‑project: define a GCP project in a simple YAML file, run one script, and let Terraform do the rest.

AutoGCP focuses on three pieces:
- A reusable Terraform module to create a GCP project and enable APIs
- A root Terraform configuration that consumes variables
- A small Python script that reads YAML, generates tfvars, and runs Terraform


### Contents

- What you’ll build
- Repository structure
- Prerequisites
- How AutoGCP works (module, root, YAML, script)
- Quickstart
- Troubleshooting
- Deliverables
- CI/CD – GitHub Actions
- Slack notifications
- Enhanced architecture
- Legacy JSON flow (optional)


### What you’ll build

- Take a YAML config file with project details
- Use it to create a new GCP project automatically
- Make it simple and reusable for anyone without writing Terraform each time


### Repository structure

This repo already includes many reusable modules under modules/ (network, subnetwork, gke, sql, etc.). For AutoGCP you will add a minimal project module and a YAML-driven workflow.

Expected layout (current repository)

```text
Automate-infra-with-python/
├── main.tf
├── variables.tf
├── output.tf
├── modules/
│   ├── cdn_and_dns/
          ├── main.tf
          ├── outputs.tf
          ├── README.md
          └── variables.tf
│   ├── cloud_run/
│   ├── cloud_sql/
│   ├── compute_instance/
│   ├── firewall/
│   ├── gke_cluster/
│   ├── iam/
│   ├── load_balancer/
│   ├── network/
│   ├── pubsub/
│   ├── storage_bucket/
│   └── subnetwork/
├── configs/
│   └── config.json
├── scripts/
│   └── manage_modules.py
├── .github/
│   └── workflows/
│       └── apply.yml
├── requirements.txt
└── README.md
```

AutoGCP additions (optional)

```text
Automate-infra-with-python/
├── configs/
│   └── example-project.yaml       # YAML input for project factory
└── scripts/
    └── deploy.py                  # YAML → tfvars → terraform apply
```

Note: In this repository you will find configs/, scripts/, and many other modules already present. You only need to add modules/project/ and scripts/deploy.py to complete the AutoGCP flow described below.


### Prerequisites

- Terraform CLI ≥ 1.3
- Python ≥ 3.8
- GCP project/organization with billing enabled
- Permissions to create projects and link billing
- gcloud installed and authenticated

Authenticate for Terraform:

```bash
gcloud auth application-default login
```


### How AutoGCP works

1) Terraform project module (`modules/project/`)

The module should:
- Create a new GCP project
- Link it to a billing account
- Add labels
- Enable required APIs

Module inputs (suggested):
- project_id (string)
- organization_id (string)
- billing_account (string)
- labels (map(string))
- apis (list(string))

2) Root Terraform (`main.tf`, `variables.tf`)

The root configuration calls the project module and wires variables to it. Example wiring (conceptual):

```hcl
module "project" {
  source           = "./modules/project"
  project_id       = var.project_id
  organization_id  = var.organization_id
  billing_account  = var.billing_account
  labels           = var.labels
  apis             = var.apis
}
```

3) YAML config (`configs/example-project.yaml`)

```yaml
project_id: "dev-intern-poc"
organization_id: "YOUR_ORG_ID"
billing_account: "XXXXXX-XXXXXX-XXXXXX"
labels:
  owner: intern
  environment: test
apis:
  - compute.googleapis.com
  - iam.googleapis.com
```

4) Python deploy script (`scripts/deploy.py`)

The script should:
- Read a YAML file (path passed as CLI arg)
- Convert it to terraform.tfvars.json or .tfvars
- Run terraform init and terraform apply -auto-approve

Example usage:

```bash
cd scripts
python deploy.py ../configs/example-project.yaml
```


### Quickstart

1. Create configs/example-project.yaml (sample above)
2. Implement modules/project/ and root main.tf to use it
3. Run the deploy script to provision the project
4. Optional: Use the GitHub Actions workflow to trigger applies/destroys via commit message or manual dispatch


### Troubleshooting

- Permission errors: Ensure your user/service account can create projects and link billing
- Billing not enabled: Verify the billing account is active and accessible
- API enablement failures: Double‑check apis list in YAML
- Auth: Re‑run gcloud auth application-default login


### Deliverables (what to submit)

- Full code and folder structure
- At least one working YAML config under configs/
- Updated README explaining how it works and how to use it


### Optional extras

- destroy.py script to clean up the project via terraform destroy
- GitHub Actions workflow that runs deploy on new YAMLs
- Notifications (Slack/email) on success/failure


### About the existing modules (optional path)

This repository also includes 12 reusable modules (network, subnetwork, storage_bucket, firewall, cloud_sql, compute_instance, gke_cluster, pubsub, load_balancer, iam, cloud_run, cdn_and_dns) and a JSON‑driven Python orchestrator at scripts/manage_modules.py. If you want to use the legacy JSON flow instead of AutoGCP YAML while the deploy.py script is being implemented, you can:

- Keep using configs/config.json to define per‑module inputs
- Run apply/destroy commands per module with manage_modules.py

Examples:

```bash
# Apply all modules
python manage_modules.py apply all

# Destroy all modules
python manage_modules.py destroy all

# Apply only GKE
python manage_modules.py apply gke_cluster

# Destroy only Cloud Run
python manage_modules.py destroy cloudrun
```


### CI/CD – GitHub Actions

This repository ships with a ready‑to‑use workflow at .github/workflows/apply&destroy.yml that can run Terraform via the Python orchestrator on push or manual dispatch.

#### Triggers

- Push to main (guarded by commit message) and workflow_dispatch with inputs
- The job runs only if the commit message contains the words deploy or destroy

#### Inputs (for workflow_dispatch)

- action: deploy or destroy
- modules: comma‑separated module names or all

#### Secrets required

- PERSONAL_GCP_CREDENTIALS: JSON of a Google service account key with required IAM
- SLACK_WEBHOOK_URL: Incoming webhook for Slack notifications

#### What it does

1) Checks out code and sets up Python and Terraform
2) Authenticates to GCP using PERSONAL_GCP_CREDENTIALS
3) Parses desired action/modules from commit message or dispatch inputs
4) Runs scripts/manage_modules.py for each target module
5) Collects terraform outputs
6) Sends Slack notification with last logs on success/failure

#### Commit message format

- deploy:<module> (e.g., deploy:network)
- destroy:<module1,module2> (e.g., destroy:network,subnetwork)
- destroy:all

#### Examples

Push‑based trigger (commit message):

```bash
git commit -m "deploy:network"
git push origin main
```

Manual dispatch (from Actions UI):

- action: deploy
- modules: gke_cluster,cloud_run


### Slack notifications

The workflow posts concise status updates and last 30 lines of logs to Slack via an incoming webhook.

#### Setup

1) Create a Slack Incoming Webhook (Workspace settings → Configure apps → Incoming Webhooks)
2) Add secret SLACK_WEBHOOK_URL in the repo → Settings → Secrets and variables → Actions
3) Ensure jq is available in the runner (GitHub‑hosted Ubuntu includes it by default)
4) Optionally adjust log tail length in the workflow

#### Message format

- Success: ✅ Infra <action> succeeded for: <modules>
- Failure: ❌ Infra <action> failed for: <modules>


Sample Slack message (real example)

```text
✅ Infra deploy succeeded for: subnetwork
Logs:
```
```
{"network_id": {
  "sensitive": false,
  "type": "string",
  "value": "projects/playground-s-11-a5e8959a/global/networks/auto-vpc"
},
"subnet_id": {
  "sensitive": false,
  "type": "string",
  "value": "projects/playground-s-11-a5e8959a/regions/us-central1/subnetworks/auto-subnet"
}}
```
```
subnet_names = [
  "app-subnet",
  "db-subnet",
]
🚀 Initializing module: subnetwork
⚡ Applying subnetwork...
✅ subnetwork apply completed successfully!
```


### Real‑world reference architecture

This section outlines a production‑ready GCP project factory and environment topology that AutoGCP can implement.

#### Resource hierarchy and environments

```text
Organization (org)
└─ Folder: platform
   ├─ Project: net-shared (Shared VPC host)
   ├─ Project: sec-logging (SIEM/log sinks)
   └─ Project: tf-state (Terraform state bucket, auditing)
└─ Folder: apps
   ├─ Folder: dev
   │  └─ Project: app-dev-<team|service>
   ├─ Folder: stage
   │  └─ Project: app-stg-<team|service>
   └─ Folder: prod
      └─ Project: app-prd-<team|service>
```

- Environments are isolated at the folder level (dev/stage/prod)
- Naming convention encodes env and ownership (labels also applied)
- Organization Policies applied at folder or org root (e.g., restrict external IPs, CMEK required)

#### Networking (Shared VPC)

- `net-shared` is the Shared VPC host project providing VPC, subnets, and firewall
- App projects are service projects attached to the host VPC
- Regional subnets per environment; egress through NAT or proxy

AutoGCP modules involved:
- `modules/network` to create VPC and subnets in host project
- `modules/subnetwork` for additional segmented subnets
- `modules/firewall` for least‑privilege rules

#### IAM and identities

- Central platform group owns host/network/state projects
- Workload Identity Federation (WIF) used for CI to access GCP without long‑lived keys
- Per‑service accounts for runtime workloads with fine‑grained roles

#### Terraform state and workspaces

- Remote backend: GCS bucket in `tf-state` project with versioning and retention
- State separated by environment and stack (e.g., project‑factory, networking, app stacks)
- Workspaces or separate state folders (recommended: separate states per env)

Example backend (conceptual):

```hcl
terraform {
  backend "gcs" {
    bucket = "tf-state-bucket"
    prefix = "envs/prod/project-factory"
  }
}
```

#### CI/CD pipeline

- GitHub Actions triggers plan/apply on PR/merge
- Auth via Google WIF using `google-github-actions/auth@v2` instead of JSON key
- Slack notifications on success/failure

Recommended CI auth (conceptual):

```yaml
- uses: google-github-actions/auth@v2
  with:
    workload_identity_provider: ${{ secrets.GCP_WIF_PROVIDER }}
    service_account: ${{ secrets.GCP_WIF_SA }}
```

#### Data/Control flow (YAML/AutoGCP)

```text
developer → configs/example-project.yaml → scripts/deploy.py → terraform init/apply → Google Cloud
                                                    ↓
                                            terraform.tfvars(.json)
```

#### Data/Control flow (JSON/legacy)

```text
developer → configs/config.json → scripts/manage_modules.py → terraform per module → Google Cloud
                                                         ↓
                                                ordered module runs
```