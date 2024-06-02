# Automated Configuration and Provisioning with Secret Management

## Overview

This project demonstrates provisioning an environment using Terraform and managing secrets with AWS Secrets Manager.

## Task

Use secret management tools and approaches such as Ansible Vault, Hashicorp Vault, or AWS SSM in configuration code.

### Example of Artifacts:	
- All variables are stored and encrypted in the secret management tool.
- Secrets are stored following the "least privilege" approach.
- RBAC has been implemented and used for accessing secrets for the IaaC tool.

Use secret management tool while using automated configuration and provisioning infrastructure
Description 

Provision a fully functional environment by using the IaC concept (from Use infrastructure as a code tool for provisioning infrastructure). 

### Acceptance criteria 

Sensitive variables are stored and encrypted in the secret management tool. 
Secrets are stored following the "least privilege" approach.
RBAC has been implemented and used for accessing secrets for the IaaC tool.
 

Pre-requirements (out of the task scope and can be used from a project or reference to another NEBo task)

VM with Linux
CaaC tool with an available agent (if needed) and verified connectivity to the infrastructure environment
CaaC tool should be installed on a local machine 
Access to Linux VM is established based on ssh-keys

## Usage
Terraform provisions an EC2 instance, injecting the administrator's password securely from AWS Secrets Manager.

## Security Practices
- Secrets Management:Encrypted and stored in AWS Secrets Manager.
- Least Privilege: Access is minimized.
- RBAC: Role-Based Access Control is implemented.