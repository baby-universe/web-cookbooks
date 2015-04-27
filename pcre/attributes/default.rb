default['pcre']['version']     = '8.36'
default['pcre']['src_dir']    = "/usr/src"

default['pcre']['prefix_dir'] = "/opt/pcre/#{pcre['version']}"
default['pcre']['configure_options'] = %W{--prefix=#{pcre['prefix_dir']}
--enable-utf8
--enable-unicode-properties
}

