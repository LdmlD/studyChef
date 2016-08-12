#
# Cookbook Name:: wpapp
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe "nginx"
include_recipe "nginx_conf"
include_recipe "php"
include_recipe "php-fpm"
include_recipe "php5-fpm"
include_recipe "php::module_mysql"

#nginx_conf_file "default" do
#  listen   80 default
  
#  access_log  /var/log/nginx/localhost.access.log
#  root   /var/www/nginx-default

#  location ~ \.php {
#               fastcgi_split_path_info ^(.+\.php)(/.+)$
#               fastcgi_pass unix:/var/run/php5-fpm.sock
#               fastcgi_index index.php
#               fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name
#               include fastcgi_params
#  }
#end

execute "change scocket" do
  command " sudo sed -rn 's#listen = /var/run/php-fpm-www.sock#listen = /var/run/php5-fpm.sock #g' /etc/php5/fpm/pool.d/www.conf"
end

cookbook_file '/etc/nginx/mime.types' do
  source 'mime.types'
  action :create
end

cookbook_file '/etc/nginx/fastcgi_params' do
  source 'fastcgi_params''
  action :create
end
