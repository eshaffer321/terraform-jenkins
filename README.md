# terraform jenkins

Create a working jenkins instance with just a few commands. Fully devloys and configures a master jenkins server.
## Getting Started

You will need the acess key / secret token inorder to modify infrastructure.
### Prerequisites

You must install terraform.
https://www.terraform.io/

### Deploying infrastructure
```
terraform plan -out=tfplan
terraform apply tfplan
```
