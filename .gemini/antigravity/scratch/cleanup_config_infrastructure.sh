#!/bin/bash

ROLE_NAME="t3_enforcement_2026_01_11_ConfigRole"
RECORDER_NAME="default"
CHANNEL_NAME="default"
BUCKET_NAME="config-bucket-935934578075.us-east-2"

echo "Deleting Configuration Recorder: $RECORDER_NAME..."
aws configservice delete-configuration-recorder --configuration-recorder-name "$RECORDER_NAME" || echo "Recorder not found or already deleted."

echo "Deleting Delivery Channel: $CHANNEL_NAME..."
aws configservice delete-delivery-channel --delivery-channel-name "$CHANNEL_NAME" || echo "Delivery channel not found or already deleted."

echo "Detaching Policy from Role: $ROLE_NAME..."
aws iam detach-role-policy --role-name "$ROLE_NAME" --policy-arn "arn:aws:iam::aws:policy/service-role/AWS_ConfigRole" || echo "Policy not attached."

echo "Deleting IAM Role: $ROLE_NAME..."
aws iam delete-role --role-name "$ROLE_NAME" || echo "Role not found or already deleted."

echo "Deleting S3 Bucket: $BUCKET_NAME..."
aws s3 rb "s3://$BUCKET_NAME" --force || echo "Bucket not found or already deleted."

echo "Infrastructure cleanup complete."
