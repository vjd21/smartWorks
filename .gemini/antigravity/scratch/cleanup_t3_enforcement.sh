#!/bin/bash

ROLE_NAME="t3_enforcement_2026_01_11_AutomationRole"
RULE_NAME="t3_enforcement_2026_01_11_rule"
DOC_NAME="t3_enforcement_2026_01_11_EnforceT3Small"

echo "Deleting Remediation Configuration for Rule: $RULE_NAME..."
aws configservice delete-remediation-configuration --config-rule-name "$RULE_NAME" || echo "Remediation configuration not found or already deleted."

echo "Deleting Config Rule: $RULE_NAME..."
aws configservice delete-config-rule --config-rule-name "$RULE_NAME" || echo "Config rule not found or already deleted."

echo "Deleting SSM Document: $DOC_NAME..."
aws ssm delete-document --name "$DOC_NAME" || echo "SSM document not found or already deleted."

echo "Detaching Policy from Role: $ROLE_NAME..."
aws iam detach-role-policy --role-name "$ROLE_NAME" --policy-arn "arn:aws:iam::aws:policy/service-role/AmazonSSMAutomationRole" || echo "Policy not attached."

echo "Deleting Inline Policy: t3_enforcement_2026_01_11_Permissions from Role: $ROLE_NAME..."
aws iam delete-role-policy --role-name "$ROLE_NAME" --policy-name "t3_enforcement_2026_01_11_Permissions" || echo "Inline policy not found or already deleted."

echo "Deleting IAM Role: $ROLE_NAME..."
aws iam delete-role --role-name "$ROLE_NAME" || echo "Role not found or already deleted."

echo "Cleanup complete."
