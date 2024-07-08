# aws-air-draft

An overview of the AWS architecture and its components used in the deployment. The architecture includes the following AWS services:

* Amazon ECS: Runs containerized applications.
* AWS Fargate: Serverless compute engine for containers.
* Amazon ECR: Stores and manages Docker container images.
* Amazon API Gateway (APIGW): Exposes APIs to external clients.
* Application Load Balancer (ALB): Distributes incoming traffic across multiple targets.
* Amazon S3: Object storage service for static assets and backups.
* Amazon CloudFront: Content delivery network (CDN) for fast content delivery.
* Amazon CloudWatch: Collects and monitors application logs.
* AWS Organizations: Centrally manages and governs AWS environment.
* AWS Transit Gateway: Establishes VPN site-to-site connections.


The deployment spans two Availability Zones (AZs) to ensure high availability (HA).
