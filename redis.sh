script=${realpath "$0"}
script_path=${dirname "$script"}
source ${script_path}/comman.sh
print_head " install repos"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>log_file
func_status_check $?
print_head " redis versions"
dnf module enable redis:remi-6.2 -y &>>log_file
func_status_check $?
print_head " install rediss"
yum install redis -y &>>log_file
func_status_check $?
print_head " change port"
sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/redis.conf &>>log_file
func_status_check $?
print_head " start service"
systemctl enable redis &>>log_file
systemctl restart redis &>>log_file
func_status_check $?