property :ngx_conf_cookbook, default: "nginx"

action :create do
  template "#{node['nginx']['conf-path']}" do 
    cookbook ngx_conf_cookbook
    source "nginx.conf.erb"
  end
end
