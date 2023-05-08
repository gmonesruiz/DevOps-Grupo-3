# This deployment requires the following steps to be completed:
     1. terraform init ./01-s3-backend
     2. terraform apply ./01-s3-backend
# The above steps will create the S3 bucket and DynamoDB table for the terraform backend
     3. terraform init ./02-EKS-Deployment
     4. terraform apply ./02-EKS-Deployment