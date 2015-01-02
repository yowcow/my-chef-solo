#
# Cookbook Name:: anyenv
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

git 'anyenv' do
  user node['anyenv']['user']
  group node['anyenv']['gname']
  repository node['anyenv']['repository']
  reference node['anyenv']['reference']
  destination node['anyenv']['destination']
  action :sync
end

bash 'env' do
  user node['anyenv']['user']
  group node['anyenv']['gname']
  code <<-COMMAND
echo '
export PATH="#{node['anyenv']['destination']}/bin:$PATH"
eval "$(anyenv init -)"
' >> #{node['anyenv']['profile']}
  COMMAND
  not_if {
    begin
      File.open(node['anyenv']['profile']).read.match(/anyenv init/)
    rescue
      false
    end
  }
end
