# Cleanup AWS Config Infrastructure

This plan describes the steps to remove the remaining AWS Config infrastructure to stop all related costs.

## User Review Required
> [!WARNING]
> This will DELETE the AWS Config Recorder and Delivery Channel, effectively disabling AWS Config in this region.
> It will also DELETE the S3 bucket `config-bucket-935934578075.us-east-2` and all its contents.

## Proposed Changes
I will create and run a shell script `cleanup_config_infrastructure.sh` to perform the following:

### AWS Config
#### [DELETE] Configuration Recorder
- Name: `default`

#### [DELETE] Delivery Channel
- Name: `default`

### IAM Configuration Role
#### [DELETE] Role and Policies
- Role Name: `t3_enforcement_2026_01_11_ConfigRole`
- Detach Policy: `arn:aws:iam::aws:policy/service-role/AWS_ConfigRole`
- Delete Instance Profile (if exists)

### S3 Storage
#### [DELETE] Bucket
- Name: `config-bucket-935934578075.us-east-2`
- Action: Force delete (empty and delete)

## Verification Plan
### Automated Verification
After running the cleanup script, I will run the following commands to verify deletion:
- `aws configservice describe-configuration-recorders`
- `aws configservice describe-delivery-channels`
- `aws iam get-role --role-name t3_enforcement_2026_01_11_ConfigRole`
- `aws s3 ls s3://config-bucket-935934578075.us-east-2`
