script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/comman.sh
rabbitmq_appuser_password=$1
if [ -z "$rabbitmq_appuser_password" ]; then
  echo input roboshop appuser password missing
  exit
  fi
  print_head " download erlang dependence"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>>log_file
func_status_check $?
print_head " install erlang"
yum install erlang -y &>>log_file
func_status_check $?
print_head " download erlang dependence"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash &>>log_file
yum install rabbitmq-server -y &>>log_file
func_status_check $?
print_head " start rabbitmq"
systemctl enable rabbitmq-server &>>log_file
systemctl  restart rabbitmq-server &>>log_file
func_status_check $?
print_head " add application user"
rabbitmqctl add_user roboshop ${rabbitmq_appuser_password} &>>log_file
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>log_file
func_status_check $?