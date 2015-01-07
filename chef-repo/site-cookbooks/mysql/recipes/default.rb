#
# Cookbook Name:: mysql
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

group "mysql" do
  action :create
end

user "mysql" do
  gid "mysql"
  shell "/bin/false"
  action :create
end

%w{libaio1 libaio-dev}.each do |pkg|
  package pkg do
    action :install
  end
end

remote_file "#{node['tmp_dir']}/mysql.tar.gz" do
  not_if { File.exists?(node['destination']) }
  source "http://dev.mysql.com/get/Downloads/MySQL-5.5/mysql-#{node['version']}-linux2.6-#{node['architecture']}.tar.gz"
  action :create_if_missing
end

bash "Extract #{node['tmp_dir']}/mysql.tar.gz" do
  code <<-COMMAND
cd #{node['tmp_dir']} && tar xvzf mysql.tar.gz
  COMMAND
  creates "/tmp/mysql-#{node['version']}-linux2.6-#{node['architecture']}"
end

bash "Move to #{node['destination']}" do
  code <<-COMMAND
mv /tmp/mysql-#{node['version']}-linux2.6-#{node['architecture']} #{node['destination']}
  COMMAND
  creates node['destination']
end

bash "Initialize MySQL" do
  code <<-COMMAND
cd #{node['destination']}
chown -R mysql .
chgrp -R mysql .
scripts/mysql_install_db --user=mysql
chown -R root .
chown -R mysql data
  COMMAND
end

template "/etc/my.cnf" do
  source "my.cnf.erb"
  action :create_if_missing
end

bash "Hardlink from /usr/local/bin to #{node['destination']}/bin/*" do
  code <<-COMMAND
cd /usr/local/bin
find #{node['destination']}/bin -type f -exec ln -s {} . \\;
  COMMAND
  creates "/usr/local/bin/mysql"
end

bash "Set up /etc/init.d/mysql.server" do
  code <<-COMMAND
cp #{node['destination']}/support-files/mysql.server /etc/init.d/
  COMMAND
  creates "/etc/init.d/mysql.server"
end

service "mysql.server" do
  supports :status => true, :start => true, :stop => true, :restart => true, :reload => true
  pattern "mysqld_safe"
  action [:enable, :start]
  subscribes :reload, "template[/etc/my.cnf]", :immediately
end
