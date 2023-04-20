echo -e "\e[36m>>>>>>>>install maven <<<<<<<<<<\e[0m"
yum install maven -y
echo -e "\e[36m>>>>>>>>add roboshop user <<<<<<<<<<\e[0m"
useradd roboshop
echo -e "\e[36m>>>>>>>>creating directory <<<<<<<<<<\e[0m"
mkdir /app
echo -e "\e[36m>>>>>>>>downloading shipping zip file <<<<<<<<<<\e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip
cd /app
echo -e "\e[36m>>>>>>>>extract zip file <<<<<<<<<<\e[0m"
unzip /tmp/shipping.zip
echo -e "\e[36m>>>>>>>>create package <<<<<<<<<<\e[0m"
mvn clean package
echo -e "\e[36m>>>>>>>>rename jar file <<<<<<<<<<\e[0m"
mv target/shipping-1.0.jar shipping.jar
echo -e "\e[36m>>>>>>>>copy the shipping service <<<<<<<<<<\e[0m"
cp /root/roboshop-shell/shipping.service /etc/systemd/system/shipping.service
echo -e "\e[36m>>>>>>>>start the service <<<<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable shipping
systemctl start shipping
echo -e "\e[36m>>>>>>>>install mysql <<<<<<<<<<\e[0m"
yum install mysql -y
echo -e "\e[36m>>>>>>>>loading schema <<<<<<<<<<\e[0m"
mysql -h mysql-dev.kanand.online -uroot -pRoboShop@1 < /app/schema/shipping.sql
echo -e "\e[36m>>>>>>>>restart the service <<<<<<<<<<\e[0m"
systemctl restart shipping