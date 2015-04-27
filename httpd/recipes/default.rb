#
# Cookbook Name:: httpd
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
configure_options = node['httpd']['configure_options'].join(" ")

cookbook_file "#{node['httpd']['src_dir']}/httpd-#{node['httpd']['version']}.tar.gz" do
  mode 0644
end

cookbook_file "#{node['httpd']['src_dir']}/apr-#{node['apr']['version']}.tar.gz" do
  mode 0644
end

cookbook_file "#{node['httpd']['src_dir']}/apr-util-#{node['apr-util']['version']}.tar.gz" do
  mode 0644
end

bash "untar and place apr & apr-util" do
  user "root"
  cwd node['httpd']['src_dir']
  code <<-EOF
  tar -zxvf httpd-#{node['httpd']['version']}.tar.gz
  tar -zxvf apr-#{node['apr']['version']}.tar.gz
  mv apr-#{node['apr']['version']} httpd-#{node['httpd']['version']}/srclib/apr
  tar -zxvf apr-util-#{node['apr-util']['version']}.tar.gz
  mv apr-util-#{node['apr-util']['version']} httpd-#{node['httpd']['version']}/srclib/apr-util
  cd httpd-#{node['httpd']['version']}
  ./configure #{configure_options}
  make
  make install
  EOF
  not_if "ls #{node['httpd']['prefix_dir']}"
end

service "httpd" do
  supports :restart => true, :start => true, :stop => true, :reload => true
  action :nothing
end

template "httpd" do
  path "/etc/init.d/httpd"
  source "httpd.erb"
  owner "root"
  group "root"
  mode "0755"
  notifies :enable, "service[httpd]"
  notifies :start, "service[httpd]"
end