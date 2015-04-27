#
# Cookbook Name:: pcre
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
configure_options = node['pcre']['configure_options'].join(" ")

cookbook_file "#{node['pcre']['src_dir']}/pcre-#{node['pcre']['version']}.tar.gz" do
  mode 0644
end

bash "install pcre" do
  user "root"
  cwd node['pcre']['src_dir']
  code <<-EOF
  tar -zxvf pcre-#{node['pcre']['version']}.tar.gz
  cd pcre-#{node['pcre']['version']}
  ./configure #{configure_options}
  make
  make install
  ln -s #{node['pcre']['prefix_dir']}/lib #{node['pcre']['prefix_dir']}/lib64
  EOF
  not_if "ls #{node['pcre']['prefix_dir']}"
end
