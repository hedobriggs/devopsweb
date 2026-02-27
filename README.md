# CI/CD Deployment to AWS EC2 Using GitHub Actions & Docker

## Introduction
In this guide, we'll walk through a simple but production‑grade CI/CD pipeline that automatically deploys a Dockerized application to an AWS EC2 instance using GitHub Actions, Docker Hub, and SSH remote execution.

Each time you push to the **main** branch, GitHub Actions:

- Builds a Docker image of your app  
- Pushes that image to Docker Hub  
- SSHes into your EC2 server  
- Stops the running container  
- Removes the stopped container  
- Pulls the new image  
- Starts a fresh container with the latest image version  

---

## ⚠️ Before You Begin — Important Prerequisite ⚠️

For this pipeline to work, you must already have an EC2 server running with the following:

- Install Docker  
- Start the Docker service  
- Modify Docker socket permission  
- Ensure the security group allows SSH access (restrict inbound SSH to your IP only)  
- Ensure inbound port **80** is allowed (if your app listens on port 80)  

---

## 🐳 Your Dockerfile (The Heart of the Deployment)

Before anything can be deployed, your app needs to be packaged into a Docker image.  
Here is the Dockerfile used in the repository:



```Dockerfile

---

## GitHub Actions Workflow

Your pipeline is defined in:

```.github/workflows/deployment.yaml

Secure the Website on AWS EC2 Using Nginx and Let's Encrypt (Certbot)
Step 1: Install and Start Nginx
Nginx will act as your reverse proxy and HTTPS termination layer.
Shellsudo dnf install -y nginxsudo systemctl enable --now nginxShow more lines

Step 2: Install Certbot (Let's Encrypt Client)
Install Certbot with Nginx support:
Shellsudo dnf install -y certbot python3-certbot-nginxShow more lines

Step 3: Configure Nginx as a Reverse Proxy
Create a config file for your domain:
Shellsudo vi /etc/nginx/conf.d/example.confShow more lines
Add:
Nginx Configserver {    listen 80;    server_name nnamdidevops.uk www.nnamdidevops.uk;    location / {        proxy_pass http://127.0.0.1:3000;        proxy_set_header Host $host;        proxy_set_header X-Real-IP $remote_addr;        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;        proxy_set_header X-Forwarded-Proto $scheme;    }}Show more lines
Test and reload:
Shellsudo nginx -tsudo systemctl reload nginxShow more lines
Your site should now load over HTTP.

Step 4: Request Your SSL Certificate
Shellsudo certbot --nginx -d nnamdidevops.uk -d www.nnamdidevops.ukShow more lines

Step 5: Verify HTTPS
Your site is now HTTPS-secured.
Verify in your browser:
https://nnamdidevops.uk

Check certificate details:
Shellsudo certbot certificatesShow more lines

Understanding What the Pipeline Does

Triggered by pushing to main
Logs into Docker Hub
Builds and pushes the Docker image
SSHes into your EC2 instance
Stops, removes, pulls, and runs the new container
