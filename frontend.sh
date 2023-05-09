script=${realpath "$0"}
script_path=${dirname "$script"}
source ${script_path}/comman.sh
 print_head " install nginx"
yum install nginx -y &>>log_file
func_status_check $?
 print_head " copy the roboshop config file"
cp roboshop.conf /etc/nginx/default.d/roboshop.conf &>>log_file
func_status_check $?
 print_head " remove old content"
rm -rf /usr/share/nginx/html/* &>>log_file
func_status_check $?
 print_head " download app content"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>log_file
cd /usr/share/nginx/html &>>log_file
func_status_check $?
 print_head " extract app content"
unzip /tmp/frontend.zip &>>log_file
func_status_check $?
 print_head " start service"
systemctl restart nginx &>>log_file
systemctl enable nginx &>>log_file
func_status_check $?