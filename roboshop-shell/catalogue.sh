source common.sh
print_head "Configure NodeJs repo"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>{log_file}
print_head "Install NodeJs"
yum install nodejs -y &>>{log_file}
print_head "Create Roboshop user"
useradd roboshop &>>{log_file}
print_head "Creating app directory"
mkdir /app &>>{log_file}
print_head "Removing the old content"
rm -rf /app/* &>>{log_file}
print_head "Downloading app content"
curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>{log_file}
cd /app
unzip /tmp/catalogue.zip &>>{log_file}
cd /app
print_head "Installing Nodejs dependencies"
npm install &>>{log_file}
print_head "Copy Systemd installations"
cp {code_dir}/configs/catalogue.service /etc/systemd/system/catalogue.service &>>{log_file}
print_head "deamon reload"
systemctl daemon-reload &>>{log_file}
print_head "enable catalogue"
systemctl enable catalogue &>>{log_file}
print_head "Start catalogue"
systemctl restart catalogue &>>{log_file}

print_head "copy mongodb repofile"
cp {code_dir}/configs/mongodb.repo /etc/yum.repos.d/mongo.repo &>>{log_file}
print_head "start mongo client"
yum install mongodb-org-shell -y &>>{log_file}
print_head "mongo schema"
mongo --host mongodb-dev.devopslearn12.store </app/schema/catalogue.js &>>{log_file}
#hey updates are done
