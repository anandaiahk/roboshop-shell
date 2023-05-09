script=${realpath "$0"}
script_path=${dirname "$script"}
source ${script_path}/comman.sh
mysql_root_password=$1
if [ -z "$mysql_root_password" ]; then
  echo input mysql root password missing
  exit
  fi
  print_head " disable mysql versions"
dnf module disable mysql -y &>>log_file
func_status_check $?
print_head " copy mysql repo file"
cp ${script_path}/mysql.repo /etc/yum.repos.d/mysql.repo &>>log_file
yum install mysql-community-server -y &>>log_file
func_status_check $?
print_head " start service"
systemctl enable mysqld &>>log_file
systemctl restart mysqld &>>log_file
func_status_check $?
print_head " reset mysql password"
mysql_secure_installation --set-root-pass $mysql_root_password &>>log_file
func_status_check $?

