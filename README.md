OVERVIEW 
========
This code has been created as a demonstration of how to write
terraform code for AWS using AWS supplied moduals. It has been
tested on MAC OS 12.4 with the following:
*   Docker Desktop
*   All of the following running within an ubuntu:20.04 container instance
    (see docker file for build example)
*   A current git client for Linux
*   AWS CLI 1.18.69
*   Terraform 1.2.5 or later
*   TF AWS 4.18.0
*   TF cloudinit 2.2.0
*   TF kubernetes 2.11.0
*   TF local 2.2.3
*   TF TLS 3.4.0
*   AWS Module terraform-aws-vpc v3.14.4
*   AWS Module terraform-aws-iam v5.3.3
*   AWS Module terraform-aws-eks v18.29.0


The code has also been tested in Azure DevOps with an AWS connector,
using "Azure Pipelines Terraform Tasks" by Charles Zipp.

The code was completed and fully tested betweeb 19-june-2022 through
21-june-2022.

DISCLAIMER
==========
This code has been provided as part of the Cohesion 2022 workshop
"One Day Workshop - Managing Multi-Cloud Infrastructure with Azure DevOps"
Use this code at your own risk. There are no guarantees. 

FILE DESCRIPTIONS
=================
Dockerfile              The docker build config file to use to create a developer
                        container.
.profile                The service user file for the docker image
main                    The directory where the terraform files are stored
main/001_main.tf        Defines AWS region, TF version, and provider versions.
                        Also defines the backend storage in AWS S3 storage.
main/005_variables.tf   Defines the variables used by modules in
                        this code package.
main/010_network.tf     Defines the VPC that the EKS cluster will
                        be bound to.
main/020_iam_user.tf    Defines the test user for this demo
main/030_eks.tf         Defines the EKS cluster, IAM roles, node
                        groups, and other resources used by the
                        cluster. Also attaches IAM roles and 
                        assigns the test user to the roles.


CONTAINER INSTALLATION
======================
1. Start docker desktop
2. Pull this repository into a directory on your desktop
3. Change to the directory where you cloned this repository
4. run "docker build -t tag_name . "
5. Change to your homedir
6. Start the container with "docker container run -dit --name test -v ${PWD}:/usr/    
   local container_name>"
7. Enter a shell on the container with "docker container exec -it test bash -c 'su -        
   cohesion2022'"
8.  Setup your API key that points to your AWS credos within a sandbox subscription.
9.  Run "aws configure" and fill in information as prompted
10. Run "aws iam list-users" to make sure your credos work
11. Change to /usr/local/main directory
12. Start the build with terraform

REFERENCES
==========
https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest
https://aws.amazon.com/quickstart/terraform-modules/?quickstart-all.sort-by=item.additionalFields.sortDate&quickstart-all.sort-order=desc
https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
https://medium.com/mlearning-ai/
https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html

