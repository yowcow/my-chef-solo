#
# Cookbook Name:: anyenv
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

git 'anyenv' do
  user 'vagrant'
  group 'vagrant'
  repository 'https://github.com/riywo/anyenv.git'
  reference "master"
  destination '/home/vagrant/.anyenv'
  action :sync
end

bash 'env' do
  user 'vagrant'
  group 'vagrant'
  code <<-COMMAND
echo '
export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"
' >> /home/vagrant/.zshenv
  COMMAND
  not_if {
    begin
      File.open('/home/vagrant/.zshenv').read.match(/anyenv init/)
    rescue
      false
    end
  }
end
