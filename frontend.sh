echo -e "\e[36m>>>>>>>>install nginx <<<<<<<<<<\e[0m"
yum install nginx -y
echo "\e[36m>>>>>>>>copy  <<<<<<<<<<\e[0m"
cp /root/roboshop-shell/roboshop.conf /etc/nginx/default.d/roboshop.conf
echo -e "\e[36m>>>>>>>>remove nginx files <<<<<<<<<<\e[0m"
rm -rf /usr/share/nginx/html/*
echo -e "\e[36m>>>>>>>>download artifacts <<<<<<<<<<\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
cd /usr/share/nginx/html
echo -e "\e[36m>>>>>>>extract zip file<<<<<<<<<<\e[0m"
unzip /tmp/frontend.zip
echo -e "\e[36m>>>>>>>>restart service <<<<<<<<<<\e[0m"
systemctl restart nginx
systemctl enable nginx