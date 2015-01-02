bash 'install ndenv' do
  user 'vagrant'
  group 'vagrant'
  code <<-COMMAND
    export PATH="/home/vagrant/.anyenv/bin:$PATH"
    eval "$(anyenv init -)"
    anyenv install ndenv
  COMMAND
  creates '/home/vagrant/.anyenv/envs/ndenv'
end

bash 'install v0.10.35' do
  user 'vagrant'
  group 'vagrant'
  code <<-COMMAND
    export PATH="/home/vagrant/.anyenv/bin:$PATH"
    eval "$(anyenv init -)"
    ndenv install v0.10.35
    ndenv global v0.10.35
    ndenv rehash
  COMMAND
  creates '/home/vagrant/.anyenv/envs/ndenv/versions/v0.10.35'
end
