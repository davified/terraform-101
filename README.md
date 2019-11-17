# Terraform 101

## Setup
```sh
# install terraform
brew install terraform

# install awscli
pip install awscli

# Create AWS account and create secret access key. Instructions here: https://blog.gruntwork.io/an-introduction-to-terraform-f17df9c6d180 (see section on Set up your AWS account)

# configure your terminal with AWS credentials
aws configure # paste your Access Key ID and a Secret Access Key when prompted. Otherwise, go with default options
```

## Copy or generate SSH key pair

```sh
# check if you have an existing key pair
ls ~/.ssh/id_rsa.pub

# [if you do, copy existing public key into clipboard]
cat ~/.ssh/id_rsa.pub | pbcopy

# [if you don't, generate new key pair]
ssh-keygen -t rsa -b 4096 -C "your_email@email.com"
cat ./id_rsa.pub | pbcopy

# and paste it in ./main.tf (the resource is aws_key_pair.my_key_pair)
```
