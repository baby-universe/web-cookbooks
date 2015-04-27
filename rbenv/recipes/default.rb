#
# Cookbook Name:: rbenv
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
%w{git ruby-devel openssl-devel readline-devel zlib-devel curl-devel libyaml-devel}.each do |pkg|
  package pkg do
    action :install
  end
end

git "/usr/local/rbenv" do
  repository "git://github.com/sstephenson/rbenv.git"
  reference "master"
  # action :sync
  action :checkout
end

bash "add-directory-for-rbenv" do
  code <<-EOC
    mkdir /usr/local/rbenv/shims /usr/local/rbenv/versions usr/local/rbenv/plugins
    groupadd rbenv
    chgrp -R rbenv /usr/local/rbenv
    chmod -R g+rwxXs /usr/local/rbenv
  EOC
end

git "/usr/local/rbenv/plugins/ruby-build" do
  repository "git://github.com/sstephenson/ruby-build.git"
  reference "master"
  # action :sync
  action :checkout
end

bash "rbenv" do
  code <<-EOC
    echo 'export RBENV_ROOT="/usr/local/rbenv"' >> /etc/profile.d/rbenv.sh
    echo 'export PATH="/usr/local/rbenv/bin:$PATH"' >> /etc/profile.d/rbenv.sh
    echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh
    source /etc/profile.d/rbenv.sh
    rbenv install #{node['rbenv']['version']}
    rbenv rehash
    rbenv global #{node['rbenv']['version']}
    rbenv versions
  EOC
end

