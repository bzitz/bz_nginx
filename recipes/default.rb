#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
#


bz_nginx_source "test dir" do
  action :create
  default_site true
  additional_flags ['--with-http_stub_status_module', '--with-pcre']
end

