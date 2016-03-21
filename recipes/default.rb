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
  version '1.8.1'
  checksum  '8f4b3c630966c044ec72715754334d1fdf741caa1d5795fb4646c27d09f797b7'
end

