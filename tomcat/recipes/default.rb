#
# Cookbook Name:: tomcat
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
cookbook_file "#{node['tomcat']['src_dir']}/apache-tomcat-#{node['tomcat']['version']}.tar.gz" do
  mode 0644
end

user "tomcat" do
  comment "apache-tomcat"
  shell "/sbin/nologin"
end

%w[ /opt /opt/tomcat /opt/tomcat/7.0.59 ].each do |path|
  directory path do
    owner "tomcat"
    group "tomcat"
    action :create
  end
end

bash "tomcat install" do
  user "root"
  cwd node['tomcat']['src_dir']
  code <<-EOF
  tar -zxvf apache-tomcat-#{node['tomcat']['version']}.tar.gz
  cp -R apache-tomcat-#{node['tomcat']['version']}/* /opt/tomcat/#{node['tomcat']['version']}
  EOF
end
