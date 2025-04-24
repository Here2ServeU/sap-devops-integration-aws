# SAP + Cloud DevOps Integration

This project demonstrates how to deploy, automate, and monitor SAP-ready infrastructure using **AWS**, **Terraform**, **Ansible**, **GitLab CI/CD**, and **Prometheus/Grafana** for observability.

## Project Goal
Enable SAP infrastructure provisioning and automation in the cloud (AWS) using DevOps best practices.

---

## Folder Structure

```
sap-devops-integration-aws/
├── terraform/           # Terraform code for AWS infrastructure
├── ansible/             # Ansible playbook for SUSE Linux setup
├── monitoring/          # Node Exporter, Prometheus, Grafana setup (placeholder)
├── .gitlab-ci.yml       # GitLab CI pipeline for IaC automation
├── README.md            # Project documentation
```

---

## Prerequisites

- AWS CLI configured
- Terraform installed
- Ansible installed
- GitLab account with CI/CD enabled
- SUSE Linux AMI or compatible EC2 AMI
- Git clone or unzip this repo:
  ```bash
  git clone https://github.com/Here2ServeU/sap-devops-integration-aws.git
  cd sap-devops-integration-aws
  ```

---

## Step-by-Step Setup

### 1. **Provision Infrastructure with Terraform**
```bash
cd terraform
terraform init
terraform apply -auto-approve
```

This will create:
- EC2 instance (SUSE Linux)
- VPC, subnet, and security groups

### 2. **Install SAP Dependencies with Ansible**
Edit your inventory file with the public IP of the EC2 instance, then:
```bash
ansible-playbook -i inventory ansible/setup-sap.yml
```

This installs:
- `uuidd`, `libaio`, `gcc`
- Starts `uuidd` for SAP compatibility

---

## CI/CD Pipeline (GitLab)

The `.gitlab-ci.yml` automates the provisioning and configuration:
```yaml
stages:
  - deploy

deploy_sap:
  stage: deploy
  script:
    - terraform init
    - terraform apply -auto-approve
    - ansible-playbook -i inventory ansible/setup-sap.yml
```

Trigger this via GitLab CI after pushing changes to your repository.

---

## Monitoring Setup

Use Node Exporter and Grafana to monitor EC2 performance:
```bash
# On EC2 (SUSE)
wget https://github.com/prometheus/node_exporter/releases/download/v1.7.0/node_exporter-1.7.0.linux-amd64.tar.gz
tar -xvf node_exporter-1.7.0.linux-amd64.tar.gz
./node_exporter &
```

Then point **Prometheus** to the EC2 IP on port `9100` and configure a dashboard in **Grafana**.

---

## Resources

- [SAP HANA Quick Start Guide (AWS)](https://aws.amazon.com/quickstart/architecture/sap-hana/)
- [GitHub: AWS QuickStart for SAP](https://github.com/aws-quickstart/quickstart-sap-hana)
- [SAP Learning Hub](https://learning.sap.com/)
- [SAP on SUSE Linux](https://www.youtube.com/watch?v=xiPvE3RKU-w)

--- 

## <div align="center">About the Author</div>

<div align="center">
  <img src="assets/emmanuel-naweji.jpg" alt="Emmanuel Naweji" width="120" height="120" style="border-radius: 50%;" />
</div>

**Emmanuel Naweji** is a seasoned Cloud and DevOps Engineer with years of experience helping companies architect and deploy secure, scalable infrastructure. He is the founder of initiatives that train and mentor individuals seeking careers in IT and has helped hundreds transition into Cloud, DevOps, and Infrastructure roles.

- Book a free consultation: [https://here4you.setmore.com](https://here4you.setmore.com)
- Connect on LinkedIn: [https://www.linkedin.com/in/ready2assist/](https://www.linkedin.com/in/ready2assist/)

Let's connect and discuss how I can help you build reliable, automated infrastructure the right way.


——

MIT License © 2025 Emmanuel Naweji

You are free to use, copy, modify, merge, publish, distribute, sublicense, or sell copies of this software and its associated documentation files (the “Software”), provided that the copyright and permission notice appears in all copies or substantial portions of the Software.

This Software is provided “as is,” without any warranty — express or implied — including but not limited to merchantability, fitness for a particular purpose, or non-infringement. In no event will the authors be liable for any claim, damages, or other liability arising from the use of the Software.
