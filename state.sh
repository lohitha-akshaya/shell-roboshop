

state=$(aws ec2 describe-instances \
    --query "Reservations[*].Instances[*].[InstanceId,State.Name]" \
    --output text)

echo "$state"
  if [ "$state" = "stopped" ]; then
    echo "$instance_id is stopped"
  fi


