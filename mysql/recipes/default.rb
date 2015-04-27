#
# Cookbook Name:: mysql
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
pkgs = node['mysql']['packages']

log "<-- mysql install start!"

pkgs.each do |pkg|
  cookbook_file "/usr/local/src/#{pkg}-5.6.13-1.el6.x86_64.rpm" do
    source "#{pkg}-5.6.13-1.el6.x86_64.rpm"
  end

  package pkg do
    action :install
    source "/usr/local/src/#{pkg}-5.6.13-1.el6.x86_64.rpm"
    provider Chef::Provider::Package::Rpm
  end
end

log "mysql install end! -->"

service 'mysql' do
  action [:start, :enable]
end
