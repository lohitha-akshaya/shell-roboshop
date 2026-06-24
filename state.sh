aws ec2 describe-instances \
    --query "Reservations[*].Instances[*].[InstanceId, State.Name]" \
    --output text | while read -r instance_id state; do
        
        if [ "$state" = "stopped" ]; then
            echo "$instance_id is stopped"
            
        elif [ "$state" = "running" ]; then
            echo "$instance_id is running safely"
            
        elif [ "$state" = "terminated" ]; then
            echo "$instance_id has been terminated"
            
        else
            echo "$instance_id is in an unknown state: $state"
        fi

done


