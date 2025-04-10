# [Workshop 2] Setting Up AWS Transit Gateway + AWS EKS

## Introduction

Welcome to the guide on setting up AWS Transit Gateway and AWS EKS, your key to understand popular enterpise architecture. This README provides a concise overview of the steps detailed in [A Practical Guide to Deploying AWS Transit Gateway and EKS](https://google.com), authored by [Lee Wook ANh](https://www.linkedin.com/in/leewookanh/).

## Prerequisites

Before diving into the setup of AWS Transit Gateway and AWS EKS, ensure you have the following prerequisites in place:

1. **AWS Account:** You'll need an AWS account. If you don't have one, sign up for a Free-Tier Account.

2. **Project Files:** Access project files in the author's GitHub portfolio.

3. **CloudFormation Templates:** Install the provided [CloudFormation templates](./pre-requisites.yaml) to create IAM roles, EC2 instances, Flow Logs, and S3 Buckets, as well as the VPCs.


## Getting Started

Let's initiate the setup process for AWS Transit Gateway:

1. **Create Transit Gateway:** In the AWS VPC dashboard, initiate the creation of a Transit Gateway. This central hub connects and streamlines your Virtual Private Clouds (VPCs).

2. **Attach VPCs:** Connect your VPCs to the Transit Gateway. Each VPC receives a dedicated subnet within the Transit Gateway to facilitate seamless communication.

3. **Configure Routing:** Ensure that traffic flows smoothly between your VPCs by setting up appropriate routing. This step is crucial for effective network connectivity.

4. **Verify Connectivity:** After completing the setup, it's essential to check the connections between your VPCs. Confirm that instances within different VPCs can communicate effectively using the ping utility.

5. **Clean Up:** After successful testing and when no longer needed, remove Transit Gateway attachments and the Transit Gateway itself to avoid unnecessary costs.

## Conclusion

In summary, AWS Transit Gateway offers a modern, user-friendly, and efficient solution for managing cloud network connections. By centralizing your network infrastructure, you gain greater flexibility and ease of management, simplifying the complexities associated with VPC peering. Embrace the future of cloud networking with Transit Gateway, and make your cloud journey smoother and more efficient.

---

Author: [Lee Wook Anh](https://www.linkedin.com/in/leewookanh/)