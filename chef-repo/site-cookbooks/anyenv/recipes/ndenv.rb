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

bash "install coffee-script" do
  user node['anyenv']['user']
  group node['anyenv']['gname']
  code <<-COMMAND
    export PATH="#{node['anyenv']['destination']}/bin:$PATH"
    eval "$(anyenv init -)"
    npm install -g coffee-script
    ndenv rehash
  COMMAND
  creates "#{node['anyenv']['destination']}/envs/ndenv/shims/coffee"
end

bash "install bower" do
  user node['anyenv']['user']
  group node['anyenv']['gname']
  code <<-COMMAND
    export PATH="#{node['anyenv']['destination']}/bin:$PATH"
    eval "$(anyenv init -)"
    npm install -g bower
    ndenv rehash
  COMMAND
  creates "#{node['anyenv']['destination']}/envs/ndenv/shims/bower"
end

bash "install mocha" do
  user node['anyenv']['user']
  group node['anyenv']['gname']
  code <<-COMMAND
    export PATH="#{node['anyenv']['destination']}/bin:$PATH"
    eval "$(anyenv init -)"
    npm install -g mocha
    ndenv rehash
  COMMAND
  creates "#{node['anyenv']['destination']}/envs/ndenv/shims/mocha"
end
