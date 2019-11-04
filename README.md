# Exemplar Two Tier AWS architecture setup mimicking the NHSBSA prod environment
This examples creates a two tier architecture with internet facing subnets and a DB subnet.
- The internet facing subnet mimicks the internet wrapper in NHS NHSBSA
- The DB subnet mimicks the private subnet where we store our DB's.

## What it does:
- Creates VPC with public and private subnet along with Internet Gateway and NAT Gateway.
- Creates Security Groups for Internet and Database with ingress and egress rules.
- Deploys three DB's through snapshots available in the SPS environment
- Deploys one EC2 server for PowerBI Gateway

## Quick Start:
- Clone the repo.
- Run AWS configure on local workstation to get settings.
- Provide Path to EC2 Key Pair and name of Key Pair in `variables.tf`.
- run `terraform init`
- run `terraform apply`
