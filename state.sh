

state=$(aws ec2 describe-instances \
    --query "Reservations[*].Instances[*].State.Name" \
    --output text)

echo "$state"
