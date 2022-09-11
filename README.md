# shellcatcher

I wanted to expirement different capabilities of Terraform such as use of providers, executing local and remote commands, copying files, and executing external scripts. So i decided to build a tool to demonstrate a very common offensive security workflow, a system to catch shells..

## Objective  

To demonstrate interactive access to a target system on successful compromise, we require a system that can hold a callback originating from a target a.k.a reverse shell. This project aim's to speed-up provisioning and deprovisioning a non-persistent compute as an attacker controlled server. By Automating workflows such as this it is easy to maintain a clean state of CSP with limited need to patch (non-persistent).

## Approach

A demonstration of various features within Terraform to setup an ephemeral Reverse Shell Catching system. The current implementation uses the following capabilities
* Assume's the executor of the tool has terrform installed and uses macOS/Linux
* Use's AWS as a provider to spawn a Amazon-EC2 compute.
* Limits SSH access to the EC2 with a security group using the executor's egress IP.
* Sets up a SSH private key to authenticate to the EC2 instance.

## Steps to execute

 1. Install terraform.
 2. From the folder where you have this project file, execute `terraform init`, `terraform plan`, `terraform apply -auto-approve`
 3. The ouput will provision a EC2 system where you can SSH to. It has 443 port opened on the internet and port 22 limited to your IP.
 4. It does not setup a listener on 443. You can use your tool pwcat/netcat/socat etc.
 5. Once you are done with the attacker system, destroy the environment as following `terrform destroy -auto-approve`.
