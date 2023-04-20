echo -e "\e[36m>>>>>>>>install rabbitmq repo file <<<<<<<<<<\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash
echo -e "\e[36m>>>>>>>>install erlang software <<<<<<<<<<\e[0m"
yum install erlang -y
echo -e "\e[36m>>>>>>>>download rabbitmq repo  <<<<<<<<<<\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash
echo -e "\e[36m>>>>>>>>install rabbitmq <<<<<<<<<<\e[0m"
yum install rabbitmq-server -y
echo -e "\e[36m>>>>>>>>start service <<<<<<<<<<\e[0m"
systemctl enable rabbitmq-server
systemctl start rabbitmq-server
echo -e "\e[36m>>>>>>>>add user <<<<<<<<<<\e[0m"
rabbitmqctl add_user roboshop roboshop123
echo -e "\e[36m>>>>>>>>permission <<<<<<<<<<\e[0m"
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"