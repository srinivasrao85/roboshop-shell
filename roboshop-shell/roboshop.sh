code_dir=$(pwd)
log_file=/tmp/roboshop.log
rm -f ${log_file}
print_head(){
  echo -e "\e[35m$1\e[0m"
}
print_head "Installing nginx"
yum install nginx -y &>>${log_file}
print_head "Removing old content"
rm -rf /usr/share/nginx/html/* &>>${log_file}
print_head "Downloading frontend content"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${log_file}
print_head "Extracting downloaded frontend"
cd /usr/share/nginx/html &>>${log_file}
unzip /tmp/frontend.zip &>>${log_file}
print_head "Copying nginx config for roboshop"
cp ${code_dir}/configs/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${log_file}
print_head "enabling nginx"
systemctl enable nginx &>>${log_file}
print_head "restarting nginx"
systemctl restart nginx &>>${log_file}
