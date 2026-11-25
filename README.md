# Ahoum Sessions API – DevOps Assignment

## 1. Project Overview

This project demonstrates a DevOps deployment setup for a containerized Sessions API.

The solution focuses on:

- Docker-based application packaging
- Infrastructure as Code using Terraform
- CI/CD automation using Jenkins
- Container image security scanning using Trivy
- AWS ECS Fargate deployment architecture
- Centralized logging and monitoring
- Autoscaling and incident recovery documentation

## 2. Architecture

The proposed production architecture uses:

- Application Load Balancer (ALB) for incoming HTTPS traffic
- Amazon ECS with AWS Fargate to run API containers
- Amazon ECR to store Docker images
- MongoDB as the application database
- AWS Secrets Manager for sensitive configuration
- Amazon CloudWatch for logs, metrics and alarms
- Amazon SNS for alert notifications

**Architecture Diagram:**

<img width="1197" height="505" alt="image" src="https://github.com/user-attachments/assets/e76e73fc-28db-4489-b40a-0fab1549ce2d" />



## 3. Technology Stack

| Technology | Purpose |
|---|---|
| Python / FastAPI | Backend API |
| Docker | Containerization |
| Docker Compose | Local application environment |
| MongoDB | Database |
| Terraform | Infrastructure as Code |
| Jenkins | CI/CD automation |
| Amazon ECS Fargate | Container runtime |
| Amazon ECR | Container registry |
| Trivy | Vulnerability scanning |
| CloudWatch | Monitoring and logging |
| SNS | Notifications |

## 4. Project Structure

```text
Ahoum-Assignment/
│
├── app/
│   ├── src/
│   ├── tests/
│   ├── Dockerfile
│   └── requirements.txt
│
├── terraform/
│   ├── environments/
│   │   └── dev/
│   └── modules/
│       ├── vpc/
│       ├── security/
│       ├── ecr/
│       ├── ecs/
│       ├── alb/
│       ├── iam/
│       ├── secrets/
│       ├── logging/
│       ├── monitoring/
│       └── autoscaling/
│
├── docs/
│   ├── runbooks/
│   └── load-test-results.md
│
├── scripts/
├── docker-compose.yml
└── jenkinsfile
```

## 5. Run Application Locally

### Prerequisites

- Docker
- Docker Compose

### Start the application

```bash
docker compose up -d --build
```

### Check running containers

```bash
docker compose ps
```

### View application logs

```bash
docker compose logs -f
```

### Stop the application

```bash
docker compose down
```

The API runs on port `8000`.

Health endpoint:

```text
http://localhost:8000/health
```

## 6. CI/CD Pipeline

Jenkins automates the application build and deployment workflow.

Pipeline stages:

1. Checkout source code from GitHub.
2. Install Python dependencies.
3. Execute application tests.
4. Build Docker image.
5. Scan the image using Trivy.
6. Push the versioned image to Amazon ECR.
7. Request manual production approval.
8. Update the ECS service.
9. Verify deployment stability.

The pipeline is designed for execution on a Linux Jenkins agent with the required AWS credentials and tools.

## 7. Infrastructure as Code

Terraform modules define the AWS infrastructure:

- VPC and subnet configuration
- Security groups
- ECR repository
- ECS cluster and service
- Application Load Balancer
- IAM roles
- Secrets Manager
- CloudWatch logging and alarms
- ECS autoscaling

### Terraform validation

```bash
terraform init -backend=false
terraform fmt -check -recursive
terraform validate
```

AWS deployment was not performed because an AWS account was not available.

## 8. Security

Security measures included in the design:

- Private subnets for ECS tasks
- Security groups restricting application access
- IAM roles following least-privilege principles
- Secrets Manager for database credentials
- ECR image scanning on push
- Trivy vulnerability scanning in CI/CD
- HTTPS listener configuration using ACM certificates

## 9. Monitoring and Alerting

CloudWatch is used for centralized application logs and infrastructure monitoring.

Configured alarm scenarios:

- ECS CPU utilization above 80%
- Application Load Balancer HTTP 5xx errors

SNS is configured as the notification mechanism for alarms.

## 10. Autoscaling

The Terraform autoscaling module defines:

| Configuration | Value |
|---|---:|
| Minimum ECS tasks | 2 |
| Maximum ECS tasks | 5 |
| Target CPU utilization | 70% |
| Scale-out cooldown | 60 seconds |
| Scale-in cooldown | 120 seconds |

## 11. Load Testing

Locust is used to generate concurrent API requests.

Test configuration:

- Virtual users: 20
- Spawn rate: 2 users per second
- Duration: 2 minutes
- Endpoints: `/health` and `/sessions`

Actual performance results are documented in:

`docs/load-test-results.md`

## 12. Operational Runbooks

The following operational scenarios are documented:

- Database unavailable
- Traffic spike
- Secret exposure
- Database backup and restoration

Refer to the `docs/runbooks/` directory.

## 13. Testing and Deployment Limitations

The application and its Docker-based environment are intended for local execution and testing.

Terraform infrastructure configuration and the Jenkins-to-ECS deployment pipeline are provided as AWS deployment designs.

No AWS infrastructure was deployed or verified because an AWS account was not available.

The Locust load test targets the local Docker deployment. ECS autoscaling configuration has not been verified against a live AWS environment.

## 14. Conclusion

This project demonstrates a containerized application deployment approach using Docker, Terraform, Jenkins and AWS ECS.

It covers CI/CD automation, infrastructure configuration, security scanning, monitoring, autoscaling design and operational recovery procedures.

## 5. Evidence and Screenshots

The `images/` folder contains screenshots and visual evidence of the project implementation and testing.



