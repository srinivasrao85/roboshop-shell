source common.sh
print_head "Set up Mongodb Repository"
cp {code_dir}/configs/mongodb.repo /etc/yum.repos.d/mongo.repo &>>{log_file}
print_head "Install Mongodb"
yum install mongodb-org -y &>>{log_file}

print_head "Enable Mongodb"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>>{log_file}
systemctl enable mongod &>>{log_file}
print_head "Start Mongodb Service"
systemctl start mongod &>>{log_file}


#Update listen address from 127.0.int0.1 to 0.0.0.0 in /etc/mongod.conf
