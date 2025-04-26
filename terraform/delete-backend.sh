#!/bin/bash

# Variables
BUCKET_NAME="t2s-bank-terraform-state"
DYNAMODB_TABLE="t2s-terraform-locks"
REGION="us-east-1"

# Delete all objects from the S3 bucket
echo "Deleting all objects in S3 bucket: $BUCKET_NAME"
aws s3api list-object-versions --bucket $BUCKET_NAME --output json \
  | jq -r '.Versions[]?, .DeleteMarkers[]? | [.Key, .VersionId] | @tsv' \
  | while IFS=$'\t' read -r Key VersionId; do
      aws s3api delete-object --bucket $BUCKET_NAME --key "$Key" --version-id "$VersionId"
    done

# Delete the S3 bucket
echo "Deleting S3 bucket: $BUCKET_NAME"
aws s3api delete-bucket --bucket $BUCKET_NAME --region $REGION

# Delete the DynamoDB table
echo "Deleting DynamoDB table: $DYNAMODB_TABLE"
aws dynamodb delete-table --table-name $DYNAMODB_TABLE --region $REGION

echo "S3 bucket and DynamoDB table deletion process finished!"
