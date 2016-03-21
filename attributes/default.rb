default['nginx']['source_version'] = '1.8.0'
default['nginx']['checksum']       = '23cca1239990c818d8f6da118320c4979aadf5386deda691b1b7c2c96b9df3d5'

default['nginx']['dir']            = "/usr/local/nginx"
default['nginx']['pid-path']       = "#{node['nginx']['dir']}/logs/nginx.pid"
default['nginx']['sbin-path']      = "#{node['nginx']['dir']}/sbin/nginx"
default['nginx']['conf-path']      = "#{node['nginx']['dir']}/conf/nginx.conf"
default['nginx']['user']           = "www-data"

default['nginx']['default_configure_flags'] = [
  "--prefix=#{node['nginx']['dir']}",
  "--conf-path=#{node['nginx']['conf-path']}",
  "--sbin-path=#{node['nginx']['sbin-path']}",
  "--pid-path=#{node['nginx']['pid-path']}",
  "--http-client-body-temp-path=#{node['nginx']['dir']}/temp_files/client_body_temp",
  "--http-fastcgi-temp-path=#{node['nginx']['dir']}/temp_files/fastcgi_temp",
  "--http-uwsgi-temp-path=#{node['nginx']['dir']}/temp_files/uwsgi_temp",
  "--http-scgi-temp-path=#{node['nginx']['dir']}/temp_files/scgi_temp"
]

#Common directories
default['nginx']['common_dirs']    = {
  "logs" => "#{node['nginx']['dir']}/logs",
  "ssl"  => "#{node['nginx']['dir']}/ssl",
  "html" => "#{node['nginx']['dir']}/html",
  "includes" => "#{node['nginx']['dir']}/includes",
  "sites-available" => "#{node['nginx']['dir']}/sites-available",
  "sites-enabled"   => "#{node['nginx']['dir']}/sites-enabled",
  "temp-files"      => "#{node['nginx']['dir']}/temp_files",
  "conf"            => "#{node['nginx']['dir']}/conf",
}

#Default Packages
default['nginx']['packages']       = ['libpcre3', 'libpcre3-dev', 'libssl-dev', 'libperl-dev', 'curl']

