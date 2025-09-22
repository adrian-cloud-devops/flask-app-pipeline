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
- **Amazon EC2 (Custom AMI)** – instances are launched from a custom AMI pre-installed with the AWS CodeDeploy Agent.This ensures that the deployment agent is always available without additional setup. Application code (Flask app + Nginx configuration) is deployed dynamically by CodeDeploy during the pipeline execution.  
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
   - When a new instance is launched, it connects to the CodeDeploy Deployment Group and retrieves the latest deployed artifact from S3.  
     This ensures every new instance always runs the current application version without re-running the entire pipeline.  

6. CloudWatch + SNS provide monitoring and notifications.  


## **Architecture Diagram**
![Architecture Diagram](docs/architecture-diagram.jpg)

## 3. Pipeline (CI/CD)

The CI/CD pipeline is implemented using AWS CodePipeline, which orchestrates the build, test, and deployment process.

- ### **Repository**  
  Source code is stored in GitHub and integrated with CodePipeline.

- ### **CodePipeline stages**
  - **Source**: Pulls the latest code from GitHub and stores it as a source artifact.
  - **Build**: CodeBuild runs according to `buildspec.yml` (install dependencies, run `pytest`, package the app).  
    The result is uploaded as a build artifact to S3.
  - **Deploy**: CodeDeploy fetches the artifact from S3 and deploys it to the EC2 instances in the ASG.

- ### **CodeBuild**
  - Uses `buildspec.yml`.
  - Executes unit tests (pytest).
  - Produces the build artifact for CodeDeploy.

- ### **CodeDeploy**
  - Uses `appspec.yml` and lifecycle hooks (`stop → install → start → validate`).
  - Integrated with Auto Scaling Group (ASG) to ensure new and replaced instances are always provisioned with the latest app.
  - Supports automated rollback on deployment failure – if the validation script fails, the deployment is reverted to the previous healthy version.