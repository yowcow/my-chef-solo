#
# Cookbook Name:: anyenv
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

git '/usr/local/anyenv' do
  not_if 'which anyenv'
  repository 'https://github.com/riywo/anyenv.git'
  reference "master"
  action :checkout
end

template '/etc/profile.d/Z99-anyenv.sh' do
  source 'anyenv.sh.erb'
  mode 0644
end
