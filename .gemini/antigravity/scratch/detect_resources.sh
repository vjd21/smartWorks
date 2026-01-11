#!/bin/bash

echo "Searching for AWS Config Rules..."
aws configservice describe-config-rules --query "ConfigRules[?contains(ConfigRuleName, 't3') || contains(ConfigRuleName, 'enforcement')].ConfigRuleName" --output text

echo "Searching for SSM Documents..."
aws ssm list-documents --document-filter-list key=Name,value=Resize --query "DocumentIdentifiers[?contains(Name, 'T3') || contains(Name, 'Resize')].Name" --output text

echo "Searching for IAM Roles..."
aws iam list-roles --query "Roles[?contains(RoleName, 'T3') || contains(RoleName, 'Enforcement')].RoleName" --output text
