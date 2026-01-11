# AWS Config Auto-Remediation Walkthrough

The setup is **complete**. The script has been executed successfully in your account (Region: `us-east-2`).

## Deployed Resources
All resources are prefixed with `t3_enforcement_2026_01_11`:

1.  **AWS Config Service**:
    *   **Recorder**: Enabled (recording all resources).
    *   **Delivery Channel**: Configured with S3 Bucket `config-bucket-<account_id>.us-east-2` to store history.
2.  **IAM Roles**:
    *   `t3_enforcement_2026_01_11_ConfigRole`: For AWS Config.
    *   `t3_enforcement_2026_01_11_AutomationRole`: For SSM Auto-Remediation.
3.  **SSM Automation Document**: `t3_enforcement_2026_01_11_EnforceT3Small`.
    *   Steps: `StopInstance` -> `ResizeInstance` (t3.small) -> `StartInstance`.
4.  **AWS Config Rule**: `t3_enforcement_2026_01_11_rule`.
    *   Checks for `t3.small` instance type compliance.
5.  **Auto-Remediation**:
    *   Links the Config Rule to the SSM Document.

## Verification Steps (Manual)

To verify the auto-remediation is working:

1.  **Launch a compliant instance** (Optional check):
    *   Launch a `t3.small` instance. Check AWS Config; it should be Compliant.

2.  **Launch a NON-compliant instance** (The real test):
    *   Launch a `t2.micro` (or any non-t3.small) instance.
    *   Wait a few minutes. AWS Config records changes periodically.
    *   **Observe**:
        *   The instance state change: `Running` -> `Stopping` -> `Stopped`.
        *   Then: `Stopped` -> `Pending` -> `Running`.
    *   **Result**: The instance type should now be `t3.small`.

### Important Note
The remediation stops the instance, resizing it, and starts it again. This implies a downtime for any non-compliant instance found.
