# shellcatcher
 An experiment with Terraform to setup ephemeral Reverse Shell Catcher.

## Steps to execute
 1. Install terraform
 2. From the folder where you have this project file, execute `terraform init`, `terraform plan`, `terraform apply -auto-approve`
 3. The ouput will provide a EC2 system where you can SSH to. It has 443 port opened from the internet.
 4. Setup your shell catcher with pwncat or nc, install your reverse shell catching tool.
 5. destro environment using `terrform destroy -auto-approve`
