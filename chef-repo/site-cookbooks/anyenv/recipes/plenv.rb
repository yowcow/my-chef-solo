bash 'install plenv' do
  user 'vagrant'
  group 'vagrant'
  code <<-COMMAND
    export PATH="/home/vagrant/.anyenv/bin:$PATH"
    eval "$(anyenv init -)"
    anyenv install plenv
  COMMAND
  creates '/home/vagrant/.anyenv/envs/plenv'
end

bash 'install 5.20.1' do
  user 'vagrant'
  group 'vagrant'
  code <<-COMMAND
    export PATH="/home/vagrant/.anyenv/bin:$PATH"
    eval "$(anyenv init -)"
    plenv install 5.20.1
    plenv global  5.20.1
    plenv rehash
  COMMAND
  creates '/home/vagrant/.anyenv/envs/plenv/versions/5.20.1'
end

bash 'install cpanm' do
  user 'vagrant'
  group 'vagrant'
  code <<-COMMAND
    export PATH="/home/vagrant/.anyenv/bin:$PATH"
    eval "$(anyenv init -)"
    plenv install-cpanm
    plenv rehash
  COMMAND
end

bash 'install default modules' do
  user 'vagrant'
  group 'vagrant'
  code <<-COMMAND
    export PATH="/home/vagrant/.anyenv/bin:$PATH"
    eval "$(anyenv init -)"
    cpanm Carton Perl::Tidy
    plenv rehash
  COMMAND
end
