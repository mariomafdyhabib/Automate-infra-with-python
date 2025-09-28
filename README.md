🚀 GCP Terraform Modules with Python Automation

This repository provides a modular Terraform setup for provisioning Google Cloud Platform (GCP) resources.
It includes 12 reusable Terraform modules and a Python automation script that allows you to manage all modules (apply / destroy) using a single config.json.

📦 Modules Included

Network – Creates a VPC network.

Subnetwork – Creates one or more subnets inside the VPC.

Storage Bucket – Manages Cloud Storage buckets.

Firewall – Configures firewall rules.

Cloud SQL – Deploys managed SQL databases.

Compute Instance – Creates VM instances.

GKE Cluster – Deploys Kubernetes clusters.

Pub/Sub – Creates topics, subscriptions, and DLQs.

Load Balancer – Configures HTTP(S) load balancers.

IAM – Creates service accounts, custom roles, and IAM bindings.

Cloud Run – Deploys serverless containers.

CDN & DNS – Configures Cloud CDN and Cloud DNS.

Each module has its own:

main.tf

variables.tf

outputs.tf

README.md

📂 Project Structure
gcp-terraform-modules/
├── network/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── README.md
├── subnetwork/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── README.md
├── storage_bucket/
├── firewall/
├── cloudsql/
├── compute_instance/
├── gke_cluster/
├── pubsub/
├── loadbalancer/
├── iam/
├── cloudrun/
├── cdn_and_dns/
config.json
manage_modules.py

⚡ Automation with Python

Instead of running terraform init / terraform apply in each module,
we use a Python script powered by python-terraform
.

✅ Features

Run all modules with a single command.

Run individual modules by name.

Works with a centralized config.json.

Supports both apply and destroy actions.

Automatically JSON-encodes complex variables (lists, dicts).

📜 Config File (config.json)

Example snippet:

{
  "network": {
    "project": "my-gcp-project",
    "region": "us-central1",
    "network_name": "auto-vpc",
    "subnet_name": "auto-subnet",
    "subnet_cidr": "10.2.0.0/24"
  },
  "subnetwork": {
    "project": "my-gcp-project",
    "region": "us-central1",
    "network_id": "projects/my-gcp-project/global/networks/auto-vpc",
    "subnets": [
      {"name": "app-subnet", "cidr": "10.30.1.0/24", "region": "us-central1"},
      {"name": "db-subnet", "cidr": "10.30.2.0/24", "region": "us-east1"}
    ]
  }
}


👉 Each module has its own section with variables.

🐍 Python Script (manage_modules.py)

Usage:

# Apply all modules
python manage_modules.py apply all

# Destroy all modules
python manage_modules.py destroy all

# Apply only GKE
python manage_modules.py apply gke_cluster

# Destroy only Cloud Run
python manage_modules.py destroy cloudrun

🛠️ Requirements

Python 3.8+

Terraform CLI installed (>= 1.3.0)

GCP SDK (gcloud) configured with credentials

Install dependencies:

pip install python-terraform

🔑 Authentication

Make sure your GCP credentials are available to Terraform:

gcloud auth application-default login

✅ Execution Order

By default, the Python script executes modules in the order they appear in config.json.
You should define the order to respect dependencies, e.g.:

network

subnetwork

firewall

compute_instance

gke_cluster

cloudsql

storage_bucket

pubsub

loadbalancer

iam

cloudrun

cdn_and_dns

🌟 Example Run
python manage_modules.py apply all


Output:

🚀 Initializing module: network
⚡ Applying network...
✅ network apply completed successfully!

🚀 Initializing module: subnetwork
⚡ Applying subnetwork...
✅ subnetwork apply completed successfully!

...

🎯 Benefits

Infrastructure is modular and reusable.

One JSON file (config.json) controls everything.

Python provides one-click automation.

Easy to extend with new modules.

## Apply all modules found in config.json in order:

python manage_modules.py apply all --config config.json --stop-on-fail


## Destroy a module:

python manage_modules.py destroy firewall --config config.json

## Apply all modules:

python manage_modules.py apply all


## Destroy all modules:

python manage_modules.py destroy all


## Apply only GKE:

python manage_modules.py apply gke_cluster


## Destroy only Cloud Run:

python manage_modules.py destroy cloudrun