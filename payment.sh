echo -e "\e[36m>>>>>>>>install python <<<<<<<<<<\e[0m"
yum install python36 gcc python3-devel -y
echo -e "\e[36m>>>>>>>>create user <<<<<<<<<<\e[0m"
useradd roboshop
echo -e "\e[36m>>>>>>>>create directory <<<<<<<<<<\e[0m"
rm -rf /app
mkdir /app
echo -e "\e[36m>>>>>>>>download zip file <<<<<<<<<<\e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip
cd /app
unzip /tmp/payment.zip
echo -e "\e[36m>>>>>>>>install python txt file <<<<<<<<<<\e[0m"
pip3.6 install -r requirements.txt
echo -e "\e[36m>>>>>>>>copy payment service file <<<<<<<<<<\e[0m"
cp /root/roboshop-shell/payment.service /etc/systemd/system/payment.service
echo -e "\e[36m>>>>>>>>restart service <<<<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable payment
systemctl restart payment