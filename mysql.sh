echo -e "\e[36m>>>>>>>>disable my sql <<<<<<<<<<\e[0m"
dnf module disable mysql -y
echo -e "\e[36m>>>>>>>>install mysql repo <<<<<<<<<<\e[0m"
cp mysql.repo /etc/yum.repos.d/mysql.repo
echo -e "\e[36m>>>>>>>>install my sql <<<<<<<<<<\e[0m"
yum install mysql-community-server -y
echo -e "\e[36m>>>>>>>>mysql start <<<<<<<<<<\e[0m"
systemctl enable mysqld
systemctl start mysqld
echo -e "\e[36m>>>>>>>>my sql user add <<<<<<<<<<\e[0m"
mysql_secure_installation --set-root-pass RoboShop@1
