property :custom_url, default: nil
property :version, default: node['nginx']['source_version']
property :checksum, default: node['nginx']['checksum'] 
property :default_site, default: node['nginx']['default_site']
property :cookbook, default: "nginx"
property :additional_flags, default: []
property :ngx_init_conf, default: "bz_nginx"
property :ngx_conf_cookbook, default: "bz_nginx"
property :mime_type_cookbook, default: "bz_nginx"
property :fastcgi_conf_cookbook, default: "bz_nginx"
property :scgi_params_cookbook, default: "bz_nginx"
property :uwsgi_params_cookbook, default: "bz_nginx"

action :create do
  service 'nginx' do
    provider Chef::Provider::Service::Upstart
    supports :status => true, :restart => true, :reload => true
    action   :nothing
  end

  include_recipe 'apt'
  include_recipe 'build-essential::default'
  
  if custom_url 
    download_url = custom_url
  else
    download_url = "http://nginx.org/download/nginx-#{version}.tar.gz"
  end
  source_pth = "/tmp/nginx-#{version}.tar.gz"

  remote_file source_pth do
    checksum   new_resource.checksum
    source     download_url
    backup     false
  end
  
  node['nginx']['packages'].each do |name|
    package name
  end

  bz_nginx_dir_setup "Common Directories" do
    action :create
  end

  bz_nginx_conf "Nginx Configuration files setup" do
    action :create
    ngx_conf_cookbook  ngx_conf_cookbook
    mime_type_cookbook  mime_type_cookbook
    fastcgi_conf_cookbook  fastcgi_conf_cookbook
    scgi_params_cookbook  scgi_params_cookbook
    uwsgi_params_cookbook  uwsgi_params_cookbook
    notifies :reload, 'service[nginx]'
  end

  if default_site 
    directory "#{node['nginx']['dir']}/html/default" 

    cookbook_file "#{node['nginx']['dir']}/html/default/index.html" do
      source "default-index.html"
    end

    template "#{node['nginx']['dir']}/sites-available/default" do
      source  "default_site.conf"
    end
    
    link "#{node['nginx']['dir']}/sites-enabled/default" do
      to "#{node['nginx']['dir']}/sites-available/default"
    end
  else
    log 'Default site would not be setup'
  end
  
  nginx_conf_flags = node['nginx']['default_configure_flags'] + additional_flags

  if ::File.exist?("#{node['nginx']['dir']}/sbin/nginx")
    bz_nginx_inventory "Gather Info" do
      action :collect
    end
  else
    node.run_state['installed_version'] = nil
    node.run_state['compiled_flags'] = nil
  end

  #unpack source code
  bash 'Unpack' do
    cwd "/tmp"
    code <<-EOH
      tar -xzvf #{source_pth} -C .
    EOH
    not_if { ::File.directory?("/tmp/nginx-#{version}") }
  end
  bash "Compile Nginx" do
    cwd "/tmp/nginx-#{version}"
    code <<-EOH
      ./configure #{nginx_conf_flags.join(' ')} && make && make install
    EOH
    not_if do
      node.run_state['installed_version'] == version &&
      node.run_state['compiled_flags'].sort == nginx_conf_flags.sort
    end
    notifies :restart, 'service[nginx]'
  end

  template "/etc/init/nginx.conf" do
    cookbook ngx_init_conf
    source "nginx-init.erb"
  end
  
  service "nginx" do
    provider Chef::Provider::Service::Upstart
    action [:enable, :start]
  end

end
