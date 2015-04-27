default['postgresql']['version']    = '9.3.6'
default['postgresql']['src_dir']    = "/usr/src"
default['postgresql']['prefix_dir'] = "/opt/postgresql/#{postgresql['version']}"

default['postgresql']['configure_options'] = %W{--prefix=#{postgresql['prefix_dir']}
}

