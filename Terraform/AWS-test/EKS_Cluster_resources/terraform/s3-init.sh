#!/bin/bash
# This file creates the S3 bucket for Terraform state

read -p "Enter the name of the S3 bucket for Terraform state: " BUCKET
read -p "Enter the name of the service: " SERVICE_NAME
read -p "Enter the AWS region: " AWS_REGION

# Create the S3 bucket and DynamoDB table for Terraform state
aws s3api create-bucket --bucket ${BUCKET} --region ${AWS_REGION} --create-bucket-configuration LocationConstraint=${AWS_REGION}
aws s3api put-bucket-acl --bucket ${BUCKET} --acl private
aws s3api put-bucket-versioning --bucket ${BUCKET} --versioning-configuration Status=Enabled
aws s3api put-public-access-block --bucket ${BUCKET} --public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true"
aws s3api put-bucket-encryption --bucket ${BUCKET} --server-side-encryption-configuration '{"Rules":[{"ApplyServerSideEncryptionByDefault":{"SSEAlgorithm":"AES256"}}]}'
aws s3api put-bucket-policy --bucket ${BUCKET} --policy "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Sid\":\"DenyUnEncryptedObjectUploads\",\"Effect\":\"Deny\",\"Principal\":\"*\",\"Action\":\"s3:PutObject\",\"Resource\":\"arn:aws:s3:::${BUCKET}/*\",\"Condition\":{\"StringNotEquals\":{\"s3:x-amz-server-side-encryption\":\"AES256\"}}}]}"
aws s3api put-bucket-lifecycle-configuration --bucket ${BUCKET} --lifecycle-configuration '{"Rules":[{"ID":"ExpireTerraformState","Prefix":"","Status":"Enabled","Expiration":{"Days":90}}]}'
aws s3api put-bucket-tagging --bucket ${BUCKET} --tagging '{"TagSet":[{"Key":"Name","Value":"TerraformState"}]}'
aws dynamodb create-table --table-name terraform-state-locking --attribute-definitions AttributeName=LockID,AttributeType=S --key-schema AttributeName=LockID,KeyType=HASH --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5

cat > terraform.tfvars << EOL
s3_tfstate = {
  bucket = "${BUCKET}"
}
EOL
terraform init -reconfigure \
    -backend-config="bucket="${BUCKET}"" \
    -backend-config="key="${SERVICE_NAME}"" \
    -backend-config="region="${AWS_REGION}"" \
    -backend-config="dynamodb_table=terraform-state-locking" \
    -backend-config="encrypt=true"
    

terraform import module.backend.aws_s3_bucket.tfstate_bucket ${BUCKET}