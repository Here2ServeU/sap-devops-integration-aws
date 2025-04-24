# SAP + Cloud DevOps Integration (Modular with Backend)

This project demonstrates how to deploy, automate, and monitor SAP-ready infrastructure using AWS, Terraform (modular setup), Ansible, GitLab CI/CD, and Prometheus/Grafana for observability. It also includes remote state management using S3 backend and DynamoDB for state locking.

## Project Goal

Enable SAP infrastructure provisioning and automation in the cloud (AWS) using DevOps best practices with environment-specific configurations (dev, stage, prod).

---

## Folder Structure

```
sap-devops-integration-aws/
├── modules/
│   └── ec2/               # Reusable EC2 module
├── environments/
│   ├── dev/
│   ├── stage/
│   └── prod/
│       └── terraform.tfvars
├── create-backend.sh      # Script to create S3 and DynamoDB
├── .gitlab-ci.yml         # GitLab CI pipeline for IaC automation
├── README.md              # Project documentation
```

---

## Prerequisites

- AWS CLI configured
- Terraform installed
- Ansible installed
- GitLab account with CI/CD enabled
- SUSE Linux AMI (or equivalent)
- A bucket `t2s-bank-terraform-state` and DynamoDB table `t2s-terraform-locks` (or run the provided script)

---

## Step-by-Step Setup

### 1. Initialize Backend (once)
```bash
chmod +x create-backend.sh
./create-backend.sh
```

### 2. Deploy by Environment
```bash
cd environments/dev         # or stage/prod
terraform init
terraform apply -var-file="terraform.tfvars"
```

---

## CI/CD Pipeline (GitLab)

The `.gitlab-ci.yml` file automates deployment:
```yaml
stages:
  - deploy

deploy_sap:
  stage: deploy
  script:
    - cd environments/dev
    - terraform init
    - terraform apply -var-file="terraform.tfvars" -auto-approve
    - ansible-playbook -i inventory ansible/setup-sap.yml
```

---

## Monitoring Setup

```bash
# On EC2 (SUSE)
wget https://github.com/prometheus/node_exporter/releases/download/v1.7.0/node_exporter-1.7.0.linux-amd64.tar.gz
tar -xvf node_exporter-1.7.0.linux-amd64.tar.gz
./node_exporter &
```

Connect Prometheus to the EC2 public IP at port 9100. Visualize metrics via Grafana.

---

## Resources

- SAP HANA Quick Start Guide (AWS): https://aws.amazon.com/quickstart/architecture/sap-hana/
- GitHub: AWS QuickStart for SAP: https://github.com/aws-quickstart/quickstart-sap-hana
- SAP Learning Hub: https://learning.sap.com/
- SAP on SUSE Linux Video: https://www.youtube.com/watch?v=xiPvE3RKU-w

## <div align="center">About the Author</div>

<div align="center">
  <img src="assets/emmanuel-naweji.jpg" alt="Emmanuel Naweji" width="120" height="120" style="border-radius: 50%;" />
</div>

### **Emmanuel Naweji**  
**Cloud & DevOps Architect | Automation Specialist | Trusted by Fortune 500**

Emmanuel Naweji is a senior Cloud and DevOps Engineer with 10+ years of experience architecting secure, scalable infrastructure across AWS, Azure, and GCP. He’s worked with leading enterprises like IBM, Comcast, and Octo, delivering automation, IaC, CI/CD, and observability solutions at scale.

As a certified AWS Solutions Architect, Terraform Associate, and CKA, Emmanuel has led cloud migrations, implemented zero-downtime deployments, and built DevSecOps strategies aligned with SOC 2 and HIPAA. Through Transformed 2 Succeed LLC, he’s mentored hundreds into successful careers, combining business impact with technical excellence.

- Book a Strategy Session: [https://here4you.setmore.com](https://here4you.setmore.com)
- LinkedIn: [https://www.linkedin.com/in/ready2assist/](https://www.linkedin.com/in/ready2assist/)

> Let’s build resilient, cost-efficient, and future-proof infrastructure that drives business success.

-----

MIT License © 2025 Emmanuel Naweji

You are free to use, copy, modify, merge, publish, distribute, sublicense, or sell copies of this software and its associated documentation files (the “Software”), provided that the copyright and permission notice appears in all copies or substantial portions of the Software.

This Software is provided “as is,” without any warranty — express or implied — including but not limited to merchantability, fitness for a particular purpose, or non-infringement. In no event will the authors be liable for any claim, damages, or other liability arising from the use of the Software.

