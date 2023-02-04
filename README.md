# Altschool-Terraform
Deploying 3 Ec2 using Terraform


# Mini Project

* Using Terraform, create 3 EC2 instances and put them behind an Elastic Load Balancer

* Make sure the after applying your plan, Terraform exports the public IP addresses of the 3 instances to a file called host-inventory

* Get a .com.ng or any other domain name for yourself (be creative, this will be a domain you can keep using) and set it up with AWS Route53 within your terraform plan, then add an A record for subdomain terraform-test that points to your ELB IP address.

* Create an Ansible script that uses the host-inventory file Terraform created to install Apache, set timezone to Africa/Lagos and displays a simple HTML page that displays content to clearly identify on all 3 EC2 instances.

* Your project is complete when one visits terraform-test.yoursdmain.com and it shows the content from your instances, while rotating between the servers as your refresh to display their unique content.

* Submit both the Ansible and Terraform files created


altschool_server_public_ip = [
  "54.167.251.149",
  "44.198.178.228",
  "54.87.190.49",
]

aws_lb_altschool_elb_dns_name = "tf-lb-20230204214424836900000003-1056704749.us-east-1.elb.amazonaws.com"
aws_lb_altschool_elb_zone_id = "Z35SXDOTRQ7X7K"


http://terraform-test.iamolusola.com/
