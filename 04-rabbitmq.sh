# #!/bin/bash

# LOGS_FOLDER="/var/log/roboshop"
# sudo mkdir -p $LOGS_FOLDER
# sudo chown -R ec2-user:ec2-user $LOGS_FOLDER
# sudo chmod -R 755 $LOGS_FOLDER
# LOG_FILE="$LOGS_FOLDER/$0.log"
# R="\e[31m"
# G="\e[32m"
# Y="\e[33m"
# P="\e[35m"
# B="\e[34m"
# N="\e[0m"
# TIMESTAMP=$(date "+%Y-%m-%d +%H:%M:%S")

# #root access
# USERID=$(id -u)

# if [ $USERID -ne 0 ]; then
#     echo -e " $TIMESTAMP [ERROR]you are $B not $N $R root user $N,please run script with $R sudo $N or $R root $N access"
#     exit 1
# fi  

# VALIDATE() {
#     if [ $1 -ne 0 ]; then
#         echo -e "$TIMESTAMP [ERROR] $2 $R failed $N"
#         exit 1
#     else
#         echo -e "$TIMESTAMP [INFO] $2 $G success $N"
#     fi

# }

# #Copying rabbitmq repo file
# cp rabbitmq.repo /etc/yum.repos.d/rabbitmq.repo
# VALIDATE $? "Adding rabbitmq repo"

# #installing rabbitmq
# #dnf install rabbitmq-server -y  &>> $LOG_FILE
# #VALIDATE $? "Installing rabbitmq"

# #Enabling and starting rabbitmq
# systemctl enable rabbitmq-server &>> $LOG_FILE
# systemctl start rabbitmq-server  &>> $LOG_FILE
# VALIDATE $? "Enabling and starting rabbitmq"

# #Adding application user and permissions
# rabbitmqctl add_user roboshop roboshop123 &>> $LOG_FILE
# rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"   &>> $LOG_FILE
# VALIDATE $? "Adding application user and permissions"

#!/bin/bash

LOGS_FOLDER="/var/log/roboshop"
sudo mkdir -p $LOGS_FOLDER
sudo chown -R ec2-user:ec2-user $LOGS_FOLDER
sudo chmod -R 755 $LOGS_FOLDER
LOGS_FILE="$LOGS_FOLDER/$0.log"

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

if [ $USERID -ne 0 ]; then
    echo -e "$TIMESTAMP [ERROR] $R Please run this script with root access $N" | tee -a $LOGS_FILE
    exit 1
fi

VALIDATE(){
    if [ $1 -ne 0 ]; then
        echo -e "$TIMESTAMP [ERROR] $2 ... $R FAILURE $N" | tee -a $LOGS_FILE
        exit 1
    else
        echo -e "$TIMESTAMP [INFO] $2 ... $G SUCCESS $N" | tee -a $LOGS_FILE
    fi
}

cp rabbitmq.repo /etc/yum.repos.d/rabbitmq.repo
VALIDATE $? "Adding rabbitmq repo"

dnf install rabbitmq-server -y &>> $LOGS_FILE
VALIDATE $? "Installing rabbitmq server"

systemctl enable rabbitmq-server &>> $LOGS_FILE
systemctl start rabbitmq-server &>> $LOGS_FILE
VALIDATE $? "Enabling and starting rabbitmq server"

rabbitmqctl add_user roboshop roboshop123 &>> $LOGS_FILE
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>> $LOGS_FILE
VALIDATE $? "setting up username and password"