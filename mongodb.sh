script=${realpath "$0"}
script_path=${dirname "$script"}
source ${script_path}/comman.sh
print_head " copy the repo files"
cp mongo.repo /etc/yum.repos.d/mongo.repo &>>log_file
func_status_check $?
print_head " install mongo"
yum install mongodb-org -y &>>log_file
func_status_check $?
print_head " change port"
sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/mongod.conf &>>log_file
func_status_check $?
print_head " start the service"
systemctl enable mongod &>>log_file
systemctl restart mongod &>>log_file
func_status_check $?
