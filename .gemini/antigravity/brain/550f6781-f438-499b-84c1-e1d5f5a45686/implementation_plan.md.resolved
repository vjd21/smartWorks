# AWS Config Auto-Remediation Plan

## Goal
Enforce EC2 instance type to be `t3.small` using AWS Config and Auto-Remediation. If an instance is found running with a different type, it will be automatically resized to `t3.small`.

## User Review Required
> [!IMPORTANT]
> The remediation process involves **STOPPING** the instance to resize it. This will cause a temporary outage for the affected instance.

> [!NOTE]
> All files will be created in `/home/vijaydurai`.
> **Naming Convention**: All created resources will be prefixed with `t3_enforcement_2026_01_11`.

## Proposed Changes

We will create a shell script `/home/vijaydurai/setup_t3_enforcement_2026_01_11.sh`.

### Components

1.  **IAM Roles**:
    *   `t3_enforcement_2026_01_11_ConfigRole`: For AWS Config to record resources.
    *   `t3_enforcement_2026_01_11_AutomationRole`: For SSM to execute the resize actions.

2.  **SSM Automation Document**:
    *   Name: `t3_enforcement_2026_01_11_EnforceT3Small`
    *   Steps:
        1.  StopInstance
        2.  ModifyInstanceAttribute (InstanceType = t3.small)
        3.  StartInstance

3.  **AWS Config Rule**:
    *   Name: `t3_enforcement_2026_01_11_rule`
    *   SourceIdentifier: `DESIRED_INSTANCE_TYPE`
    *   InputParameters: `{"instanceType": "t3.small"}`

4.  **Remediation Configuration**:
    *   TargetType: `SSM_DOCUMENT`
    *   TargetId: `t3_enforcement_2026_01_11_EnforceT3Small`
    *   Parameters: `AutomationAssumeRole` (pointing to the new AutomationRole)

## Verification Plan
*   Run the generated script.
*   Launch a test instance (e.g., `t2.micro`).
*   Observe AWS Config triggering the remediation and resizing it to `t3.small`.
