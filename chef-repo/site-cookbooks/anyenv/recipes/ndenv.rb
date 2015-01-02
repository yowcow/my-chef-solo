bash 'install ndenv' do
  user node['anyenv']['user']
  group node['anyenv']['gname']
  code <<-COMMAND
    export PATH="#{node['anyenv']['destination']}/bin:$PATH"
    eval "$(anyenv init -)"
    anyenv install ndenv
  COMMAND
  creates "#{node['anyenv']['destination']}/envs/ndenv"
end

bash "install node.js #{node['nodejs']['version']}" do
  user node['anyenv']['user']
  group node['anyenv']['gname']
  code <<-COMMAND
    export PATH="#{node['anyenv']['destination']}/bin:$PATH"
    eval "$(anyenv init -)"
    ndenv install #{node['nodejs']['version']}
    ndenv global  #{node['nodejs']['version']}
    ndenv rehash
  COMMAND
  creates "#{node['anyenv']['destination']}/envs/ndenv/versions/#{node['nodejs']['version']}"
end
