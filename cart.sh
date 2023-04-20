echo -e "\e[36m>>>>>>>>download nodej setup<<<<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
echo -e "\e[36m>>>>>>>>install nodejs <<<<<<<<<<\e[0m"
yum install nodejs -y
echo -e "\e[36m>>>>>>>>add user <<<<<<<<<<\e[0m"
useradd roboshop
echo -e "\e[36m>>>>>>>>create directory <<<<<<<<<<\e[0m"
mkdir /app
echo -e "\e[36m>>>>>>>>download artifacts <<<<<<<<<<\e[0m"
curl -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip
cd /app
echo -e "\e[36m>>>>>>>>extract the file <<<<<<<<<<\e[0m"
unzip /tmp/cart.zip
echo -e "\e[36m>>>>>>>>install npm <<<<<<<<<<\e[0m"
npm install
echo -e "\e[36m>>>>>>>>copy cart service <<<<<<<<<<\e[0m"
cp /root/roboshop-shell/cart.service /etc/systemd/system/cart.service
echo -e "\e[36m>>>>>>>>start service <<<<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable cart
systemctl restart cart

