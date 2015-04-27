default['php']['version']   = '5.5.9'
default['php']['src_dir']    = "/usr/src"
default['php']['prefix_dir'] = "/opt/php/#{php['version']}"

default['httpd']['version'] = '2.4.7'
default['httpd']['prefix_dir'] = "/opt/httpd/#{httpd['version']}"

default['php']['configure_options'] = %W{--prefix=/opt/php/5.5.9
                                            --with-libdir=lib64
                                            --with-apxs2=/opt/httpd/2.4.7/bin/apxs
                                            --enable-mbstring
                                            --enable-intl
                                            --with-icu-dir=/usr
                                            --with-gettext=/usr
                                            --with-pcre-regex=/opt/pcre/8.36
                                            --with-readline=/usr
                                            --with-libxml-dir=/usr/bin/xml2-config
                                            --enable-soap
                                            --enable-wddx
                                            --with-xmlrpc
                                            --with-xsl=/usr
                                            --with-mysql=mysqlnd
                                            --with-mysqli=mysqlnd
                                            --with-pdo-mysql=mysqlnd
                                            --with-pgsql=/opt/postgresql/9.3.6
                                            --with-pdo-pgsql=/opt/postgresql/9.3.6
                                            --with-zlib=/usr
                                            --with-zlib-dir=/usr
                                            --enable-dba
                                            --with-db4=/usr
                                            --with-gd
                                            --with-jpeg-dir=/usr
                                            --with-png-dir=/usr
                                            --with-freetype-dir=/usr
                                            --enable-gd-native-ttf
                                            --enable-gd-jis-conv
                                            --with-openssl=/usr
                                            --with-mcrypt=/usr
                                            --with-zip=/usr
                                            --enable-bcmath}

