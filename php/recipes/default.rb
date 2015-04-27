#
# Cookbook Name:: php
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

pkgs = %w{
  libxml2-devel
  openssl-devel
  db4-devel
  libjpeg-devel
  libpng-devel
  freetype-devel
  libicu-devel
  readline-devel
  libxslt-devel
}.each do |pkg|
  package pkg do
    action :install
  end
end

template "epel.repo" do
  path "/etc/yum.repos.d/epel.repo"
  source "epel.repo.erb"
  owner "root"
  group "root"
  mode "0755"
end

bash "install libmcrypt" do
  user "root"
  cwd "/usr/src"
  code <<-EOF
  wget http://ftp.riken.jp/Linux/fedora/epel/RPM-GPG-KEY-EPEL-6
  rpm --import RPM-GPG-KEY-EPEL-6
  rm -f RPM-GPG-KEY-EPEL-6
  yum --enablerepo=epel -y install libmcrypt-devel
  EOF
end

configure_options = node['php']['configure_options'].join(" ")

cookbook_file "#{node['php']['src_dir']}/php-#{node['php']['version']}.tar.gz" do
  mode 0644
end

bash "build php" do
  user "root"
  cwd node['php']['src_dir']
  code <<-EOF
  tar -zxvf php-#{node['php']['version']}.tar.gz
  cd php-#{node['php']['version']}
  ./configure #{configure_options}
  make
  make install
  EOF
  not_if "ls #{node['php']['prefix_dir']}"
end

#php.iniのコピー
#PEAR DB インストール
#Smarty インストール



