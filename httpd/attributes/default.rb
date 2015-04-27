default['httpd']['version']    = '2.4.7'
default['apr']['version']      = '1.5.0'
default['apr-util']['version'] = '1.5.3'
default['pcre']['version']     = '8.36'
default['php']['version']      = '5.5.9'

default['httpd']['src_dir']    = "/usr/src"
default['httpd']['prefix_dir'] = "/opt/httpd/#{httpd['version']}"
default['httpd']['pcre_dir']   = "/opt/pcre/#{pcre['version']}"

default['httpd']['configure_options'] = %W{--prefix=#{httpd['prefix_dir']}
--with-pcre=/opt/pcre/#{pcre['version']}
--with-mpm=prefork
--enable-ssl
}
