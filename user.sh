echo -e "\e[36m>>>>>>>>download nodej setup<<<<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
echo -e "\e[36m>>>>>>>>install nodejs<<<<<<<<<<\e[0m"
yum install nodejs -y
echo -e "\e[36m>>>>>>>>create user<<<<<<<<<<\e[0m"
useradd roboshop
echo -e "\e[36m>>>>>>>>create directory<<<<<<<<<<\e[0m"
mkdir /app
echo -e "\e[36m>>>>>>>>download artifacts<<<<<<<<<<\e[0m"
curl -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip
cd /app
echo -e "\e[36m>>>>>>>>extract zip file<<<<<<<<<<\e[0m"
unzip /tmp/user.zip
echo -e "\e[36m>>>>>>>>npm install<<<<<<<<<<\e[0m"
npm install
echo -e "\e[36m>>>>>>>>copy the service<<<<<<<<<<\e[0m"
cp /root/roboshop-shell/user.service /etc/systemd/system/user.service
echo -e "\e[36m>>>>>>>>start service<<<<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable user
systemctl restart user
echo -e "\e[36m>>>>>>>>copy the mongo<<<<<<<<<<\e[0m"
cp /root/roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo
echo -e "\e[36m>>>>>>>>install mongo<<<<<<<<<<\e[0m"
yum install mongodb-org-shell -y
echo -e "\e[36m>>>>>>>>load mongo schema<<<<<<<<<<\e[0m"
mongo --host mongodb-dev.kanand.online</app/schema/user.js
