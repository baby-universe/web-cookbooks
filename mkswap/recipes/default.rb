#
# Cookbook Name:: mkswap
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
bash 'create swapfile' do
  code <<-EOC
    dd if=/dev/zero of=/var/swapfile bs=1M count=2048 &&
    chmod 600 /swap.img &&
    mkswap /swap.img
  EOC
  only_if { not node[:ec2].nil? and node[:ec2][:instance_type] == 't2.micro' }
  creates "/swap.img"
end

mount '/dev/null' do  # swap file entry for fstab
  action :enable  # cannot mount; only add to fstab
  device '/swap.img'
  fstype 'swap'
  only_if { not node[:ec2].nil? and node[:ec2][:instance_type] == 't2.micro' }
end

bash 'activate swap' do
  code 'swapon -a'
  only_if { not node[:ec2].nil? and node[:ec2][:instance_type] == 't2.micro' }
end