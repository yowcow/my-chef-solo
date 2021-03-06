bash 'install plenv' do
  user node['anyenv']['user']
  group node['anyenv']['gname']
  code <<-COMMAND
    export PATH="#{node['anyenv']['destination']}/bin:$PATH"
    eval "$(anyenv init -)"
    anyenv install plenv
  COMMAND
  creates "#{node['anyenv']['destination']}/envs/plenv"
end

bash "install perl #{node['perl']['version']}" do
  user node['anyenv']['user']
  group node['anyenv']['gname']
  code <<-COMMAND
    export PATH="#{node['anyenv']['destination']}/bin:$PATH"
    eval "$(anyenv init -)"
    plenv install #{node['perl']['version']}
    plenv global  #{node['perl']['version']}
    plenv rehash
  COMMAND
  creates "#{node['anyenv']['destination']}/envs/plenv/versions/#{node['perl']['version']}"
end

bash 'install cpanm' do
  user node['anyenv']['user']
  group node['anyenv']['gname']
  code <<-COMMAND
    export PATH="#{node['anyenv']['destination']}/bin:$PATH"
    eval "$(anyenv init -)"
    plenv install-cpanm
    plenv rehash
  COMMAND
  creates "#{node['anyenv']['destination']}/envs/plenv/shims/cpanm"
end

bash 'install Carton' do
  user node['anyenv']['user']
  group node['anyenv']['gname']
  code <<-COMMAND
    export PATH="#{node['anyenv']['destination']}/bin:$PATH"
    eval "$(anyenv init -)"
    cpanm Carton
    plenv rehash
  COMMAND
  creates "#{node['anyenv']['destination']}/envs/plenv/shims/carton"
end

bash 'install Perl::Tidy' do
  user node['anyenv']['user']
  group node['anyenv']['gname']
  code <<-COMMAND
    export PATH="#{node['anyenv']['destination']}/bin:$PATH"
    eval "$(anyenv init -)"
    cpanm Perl::Tidy
    plenv rehash
  COMMAND
  creates "#{node['anyenv']['destination']}/envs/plenv/shims/perltidy"
end

#bash 'install Plack' do
#  user node['anyenv']['user']
#  group node['anyenv']['gname']
#  code <<-COMMAND
#    export PATH="#{node['anyenv']['destination']}/bin:$PATH"
#    eval "$(anyenv init -)"
#    cpanm Task::Plack
#    plenv rehash
#  COMMAND
#  creates "#{node['anyenv']['destination']}/envs/plenv/shims/plackup"
#end
