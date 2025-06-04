# [Workshop 2] AWS EKS in the world of microservices

## Introduction

Google's [microservices-demo](https://github.com/GoogleCloudPlatform/microservices-demo) (also known as "Online Boutique") is a popular cloud-native e-commerce application consisting of 11 microservices. Deploying it on AWS EKS (Elastic Kubernetes Service) demonstrates modern container orchestration in a cloud environment, authored by [Lee Wook ANh](https://www.linkedin.com/in/leewookanh/).




# TODO: Write doc
## Prerequisites

Before provisioning an Amazon EKS cluster using Terragrunt and Terraform, ensure you have the following prerequisites in place:

1. **AWS Account:** You'll need an AWS account with appropriate IAM permissions to create EKS clusters, VPCs, and other related resources.

2. **AWS CLI:** Install and configure the [AWS CLI](https://aws.amazon.com/cli/) with your credentials.

3. **kubectl:** Install [kubectl](https://kubernetes.io/docs/tasks/tools/), the Kubernetes command-line tool.

4. **Terraform & Terragrunt:** Install [Terraform](https://www.terraform.io/downloads) and [Terragrunt](https://terragrunt.gruntwork.io/docs/getting-started/install/).

5. **Helm:** Install [Helm](https://helm.sh/docs/intro/install/), the Kubernetes package manager.

6. **Git:** Ensure Git is installed for cloning repositories.

## Getting Started

Follow these steps to provision an EKS cluster and deploy a sample microservices application:

1. **Clone the repository:**  
```bash
   git clone [FCJ-2025](https://github.com/LeeSanTee/FCJ-2025.git)
   cd workshop-2
```

2 **Create a VPC:**
```
    cd terrgrunt/vpc
    terragrunt apply
```

3. **Create an EKS Cluster:**
```bash
   cd terragrunt/eks
   terragrunt apply
```

4. **Configure kubectl:**
```bash
   aws eks --region <your-region> update-kubeconfig --name <your-cluster-name>
```

5.1 **Deploy the microservices application:**
```bash
   kubectl apply -f ./demo-microservice/kubectl
```

5.2 **Deploy the microservices application using Helm:**
```bash
   cd demo-microservice/helm-chart
   helm install microservices-demo . -f values.yaml
```

6. **Access the application:**  
   After deployment, you can access the application using the LoadBalancer URL provided by the EKS service. Use the following command to get the URL:
```bash
   kubectl get svc frontend -n default
```
## Testing the Application
To test the deployed microservices application, follow these steps:
1. **Access the Application:**  
   Open a web browser and navigate to the LoadBalancer URL obtained in the previous step. You should see the e-commerce application interface.
2. **Browse Products:**
   Explore the available products, view details, and add items to your cart.
3. **Add to Cart:**
   Select products and add them to your shopping cart.
4. **Checkout:**
   Proceed to checkout, where you can simulate a purchase by entering dummy payment information.
5. **Monitor Logs:**
   Use the following command to monitor logs for the frontend service:
```bash
   kubectl logs -f deployment/frontend -n default
```
## Clean Up
After successful testing and when no longer needed, you can clean up the resources to avoid unnecessary costs:
1. **Delete the EKS Cluster:**
```bash
   cd terragrunt/eks
   terragrunt destroy
```

2. **Delete the VPC:**
```bash
   cd terragrunt/vpc
   terragrunt destroy
```

## Conclusion
In summary, AWS EKS provides a powerful platform for deploying and managing microservices applications in a cloud-native environment. By leveraging Kubernetes, you can achieve scalability, resilience, and efficient resource utilization. The provided steps guide you through the process of setting up an EKS cluster and deploying a sample microservices application, showcasing the capabilities of modern container orchestration.

---

Author: [Lee Wook Anh](https://www.linkedin.com/in/leewookanh/)