app_user=roboshop
script=$(realpath "$0")
script_path=$(dirname "$script")
log_file=/tmp/roboshop.log

print_head() {
  echo -e "\e[36m>>>>>>>> $1 <<<<<<<<<\e[0m"
}
func_status_check() {
  if [ $1 -eq 0 ]; then
         echo -e "\e[36msuccess\e[0m"
         else
           echo -e "\e[31mfailure\e[0m"
           echo " refer the log file /tmp/roboshop.log for more information"
           exit 1
           fi
}
func_schema_setup() {
  if [ "$schema_setup" == "mango" ]; then
    print_head "copy mongodb repo"
  cp ${script_path}/mongo.repo /etc/yum.repos.d/mongo.repo &>>log_file
  func_status_check $?
  print_head "install mongodb repo files"
  yum install mongodb-org-shell -y &>>log_file
  func_status_check $?
  print_head "load schema"
  mongo --host mongodb-dev.kanand.online </app/schema/${component}.js &>>log_file
  func_status_check $?
  fi
  if[ "$schema_setup" == "mysql" ]; then

      print_head " install mysql"
      yum install mysql -y &>>log_file
      func_status_check $?
      print_head "load schema"
      mysql -h mysql-dev.kanand.online -uroot -p${mysql_root_password} < /app/schema/shipping.sql &>>log_file
      func_status_check $?
    fi
}
func_app_prereq() {
  print_head "create app user"
  id ${app_user} &>>log_file
  if [ $? -ne 0 ]; then
    useradd ${app_user} &>>log_file
    fi
    func_status_check $?
    print_head " create app directory"
    rm -rf /app &>>log_file
    mkdir /app &>>log_file
    func_status_check $?
    print_head " download  content"
    curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>log_file
    cd /app
    func_status_check $?
    print_head " unzip the  the file"
    unzip /tmp/${component}.zip &>>log_file
    func_status_check $?
}
func_systemd_setup() {
print_head "setup systemd service"
  cp ${script_path}/${component}.service /etc/systemd/system/${component}.service &>>log_file
  func_status_check $?
  print_head "start the ${component} service"
    systemctl daemon-reload &>>log_file
    systemctl enable ${component} &>>log_file
     systemctl restart ${component} &>>log_file
     func_status_check $?

}
func_nodejs() {
 print_head "configure nodejs repo"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>log_file
  func_status_check $?
  print_head "install nodejs"
  yum install nodejs -y &>>log_file
  func_status_check $?
  func_app_prereq
  print_head "install nodejs dependences"
  npm install &>>log_file
  func_status_check $?
  func_systemd_setup
  func_schema_setup
}

func_java() {
  print_head "install maven"
  yum install maven -y &>>log_file
  func_status_check $?
  func_app_prereq
   print_head " download maven dependence"
   mvn clean package &>>log_file
    func_status_check $?
   print_head " rename the jar file"
   mv target/${component}-1.0.jar ${component}.jar &>>log_file
func_schema_setup
func_systemd_setup
}

func_python() {
  print_head "install python"
  yum install python36 gcc python3-devel -y &>>log_file
 func_app_prereq
  print_head " install python dependence"
  pip3.6 install -r requirements.txt &>>log_file
   func_status_check $?
   print_head " update system password file"
  sed -i -e "s|rabbitmq_appuser_password|${rabbitmq_appuser_password}"| ${script_path}/${component}.service &>>log_file
     func_status_check $?
  func_systemd_setup