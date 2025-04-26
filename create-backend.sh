#!/bin/bash

# Variables
BUCKET_NAME="t2s-bank-terraform-state"
DYNAMODB_TABLE="t2s-terraform-locks"
REGION="us-east-1"

# Create S3 bucket
echo "Creating S3 bucket: $BUCKET_NAME"

if [ "$REGION" == "us-east-1" ]; then
  aws s3api create-bucket --bucket $BUCKET_NAME
else
  aws s3api create-bucket --bucket $BUCKET_NAME --region $REGION --create-bucket-configuration LocationConstraint=$REGION
fi

# Enable versioning
echo "Enabling versioning on S3 bucket"
aws s3api put-bucket-versioning --bucket $BUCKET_NAME --versioning-configuration Status=Enabled

# Create DynamoDB table for state locking
echo "Creating DynamoDB table: $DYNAMODB_TABLE"
aws dynamodb create-table \
  --table-name $DYNAMODB_TABLE \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 \
  --region $REGION || echo "DynamoDB table $DYNAMODB_TABLE already exists, skipping."

echo "S3 bucket and DynamoDB table creation process finished!"
