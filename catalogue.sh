curl -sL https://rpm.nodesource.com/setup_lts.x | bash
yum install nodejs -y
useradd roboshop
rm -rf /app
mkdir /app
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app
unzip /tmp/catalogue.zip
npm install
cp /home/centos/roboshop-shell/catalogue.service /etc/systemd/system/catalogue.service
systemctl daemon-reload
systemctl enable catalogue
systemctl restart catalogue
cp /home/centos/roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo
yum install mongodb-org-shell -y
echo -e "\e[36m <<<<<<<<<<<connection mongodb >>>>>>>>>>\e[0m"
mongo --host 172.31.28.38 </app/schema/catalogue.js
