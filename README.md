**Networking - Homework III**

Author: Leonardo Villalba

The goal in this project is to use terraform to make the following infrastructure in AWS:

- Office 1: 80 hosts
- Office 2: 500 hosts
- Office 3: 40 hosts
- Remote Office: 30 hosts (public subnet)

After analyzing the requirements for this infraestructure, we realized these are the elements required to proceed:

- VPC
- Subnets (4)
- Route table
- Internet gateway
- Route table associations
- AWS Key pair
- Security group (2)
- EC2 instance (4)

**Workflow**

1. Create a VPC module.
    
    1.1 We defined a structure to iterate over private and public subnets, so after picking a map, and the vpc_cidr we make the proper variables and outputs in addition to the proper resources. To make terraform recognize a module and to start constructing the plan we use the command:

    ```
        $ terraform init
    ```

    1.2 Please keep in mind, that in order to interact with AWS it is necesary to stablish a conection with the AWS terraform provider, and also, to connect using AWS cli. You need to have an Identity and Access Management (IAM). 

    ```
        $ aws configure
    ```

    1.3 With the module completed we create the Route table associations out of the module to be able to catch the subnets id as an output varible. With this we move forward an check our plan and apply id to make sure we have 1 public and 3 private subnets with valid cidr addresses.

    ```
        $ terraform plan -out main.tfplan
    ```

2. Create an EC2 module

    2.1 With the same principle and catching the subnets id from the VPC module we create the EC2 module. Please it is important to consider that the EC2 module depends on the VPC module, so we need to build VPC module first using the following command in case the plan wasn't applied yet:

    ```
        $ terraform plan -target=module.<moduleName> -out main.tfplan
        $ terraform apply
    ``` 

    2.2 One of the achivement in this excercise is to connect a private ec2 through ssh from the public ec2. To do that, with will use two security grups, one configured to access ssh from anywhere, and the other one to access from the specific cidr address of the public subnet.

3. Destroy

    3.1 Destroy.

    ```
        $ terraform destroy
    ```






