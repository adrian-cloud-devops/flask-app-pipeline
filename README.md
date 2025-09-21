# **Flask Todo App – CI/CD on AWS**

## 1. Introduction

This project demonstrates a complete CI/CD pipeline on AWS for a sample Python Flask application.
The application is deployed on EC2 instances managed by an Auto Scaling Group (ASG), behind an Application Load Balancer (ALB). The deployment process is automated with AWS CodePipeline, CodeBuild, and CodeDeploy.

To ensure reliability and observability, the project integrates Amazon CloudWatch for monitoring (CPU usage, Nginx error logs) and Amazon SNS for alert notifications.

### 🎯 **Project Goals**

- Build a production-like DevOps pipeline using AWS services.

- Learn how to connect multiple AWS components into a working end-to-end deployment.

- Demonstrate scalability, monitoring, and alerting on a real web application.

### 🛠️ **Technologies Used**

- AWS: CodePipeline, CodeBuild, CodeDeploy, EC2, ASG, ALB, CloudWatch, SNS

- Python: Flask web application (REST API + HTML)

- Nginx: Reverse proxy (port 80 → 5000)

- GitHub: Source code repository

## **2. Architecture**

The project follows a cloud-native architecture with a focus on automation, scalability, and monitoring.  
A simple Flask Todo application is deployed on multiple EC2 instances inside an Auto Scaling Group (ASG), behind an Application Load Balancer (ALB). The entire process is orchestrated by a CI/CD pipeline built with AWS services.  

### **🔹 Key Components**
- **AWS CodePipeline** – orchestrates the CI/CD process (Source → Build → Deploy).  
- **AWS CodeBuild** – executes commands defined in **buildspec.yml**, runs unit tests (pytest), and produces the deployment artifact.  
- **AWS CodeDeploy** – handles deployment to EC2 instances using lifecycle hooks defined in **appspec.yml**.  
- **Amazon EC2** – runs the Flask application with Nginx reverse proxy.  
- **Auto Scaling Group (ASG)** – ensures at least 2 running instances (desired = 2, minimum = 2, maximum = 3), distributes them across 3 Availability Zones (AZs) for high availability, and provides self-healing: if an instance or application becomes unhealthy, ASG automatically terminates and replaces it.  
- **Application Load Balancer (ALB)** – distributes incoming traffic across instances in multiple AZs, performs health checks, and ensures high availability.  
- **Amazon CloudWatch** – monitors system metrics (CPU) and log groups (Nginx access/error, Flask application logs).  
- **Amazon SNS** – delivers email alerts triggered by CloudWatch alarms.  

### **🔹 Deployment Flow**
1. Developer pushes code to **GitHub**.  
2. CodePipeline is triggered automatically.  
3. CodeBuild runs `buildspec.yml`, executes unit tests, and prepares the deployment package.  
4. CodeDeploy installs the new version on EC2 instances using lifecycle hooks (`BeforeInstall`, `AfterInstall`, `ApplicationStart`, `ValidateService`).  
5. ASG + ALB ensure high availability:  
   - Rolling deployment replaces instances gradually.  
   - Instances are spread across 3 AZs for fault tolerance.  
   - ASG runs minimum 2 and up to 3 instances, ensuring resilience and controlled scaling.  
   - ASG self-healing guarantees failed instances are replaced automatically.  
6. CloudWatch + SNS provide monitoring and notifications.  

