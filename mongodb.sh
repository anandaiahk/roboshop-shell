echo -e "\e[36m>>>>>>>>copy mongo repo <<<<<<<<<<\e[0m"
cp mongo.repo /etc/yum.repos.d/mongo.repo
echo -e "\e[36m>>>>>>>>install mongo file <<<<<<<<<<\e[0m"
  yum install mongodb-org -y
  echo -e "\e[36m>>>>>>>>update ports <<<<<<<<<<\e[0m"
  sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/mongod.conf
  echo -e "\e[36m>>>>>>>>restart service <<<<<<<<<<\e[0m"
  systemctl enable mongod
  systemctl restart mongod

