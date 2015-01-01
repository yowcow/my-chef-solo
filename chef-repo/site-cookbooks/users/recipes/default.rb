#
# Cookbook Name:: users
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

user 'vagrant' do
  shell '/bin/zsh'
end

bash 'install dotfiles' do
  user 'vagrant'
  group 'vagrant'
  cwd '/home/vagrant'
  code <<-EOC
    cd /home/vagrant && git clone https://github.com/yowcow/dotfiles.git
  EOC
  creates '/home/vagrant/dotfiles'
end

bash 'install to vagrant' do
  user 'vagrant'
  group 'vagrant'
  cwd '/home/vagrant'
  code <<-EOC
    cd /home/vagrant/dotfiles && make && make install
  EOC
end
