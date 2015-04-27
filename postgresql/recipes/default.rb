#
# Cookbook Name:: postgresql
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
configure_options = node['postgresql']['configure_options'].join(" ")

cookbook_file "#{node['postgresql']['src_dir']}/postgresql-#{node['postgresql']['version']}.tar.gz" do
  mode 0644
end

bash "build postgresql" do
  user "root"
  cwd node['postgresql']['src_dir']
  code <<-EOF
  tar -zxvf postgresql-#{node['postgresql']['version']}.tar.gz
  cd postgresql-#{node['postgresql']['version']}
  ./configure #{configure_options}
  gmake
  gmake install
  adduser postgres
  mkdir node['postgresql']['prefix_dir']/data
  chown postgres node['postgresql']['prefix_dir']/data
  su - postgres
  node['postgresql']['prefix_dir']/bin/initdb -D node['postgresql']['prefix_dir']/data
  node['postgresql']['prefix_dir']/bin/postgres -D node['postgresql']['prefix_dir']/data >logfile 2>&1 &
  EOF
  not_if "ls #{node['postgresql']['prefix_dir']}"
end
