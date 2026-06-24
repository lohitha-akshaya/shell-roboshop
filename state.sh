

state=$(aws ec2 describe-instances \
    --query "Reservations[*].Instances[*].[InstanceId,State.Name]" \
    --output text)

echo "$state"
