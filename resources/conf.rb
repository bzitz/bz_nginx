
action :create do
  template "#{node['nginx']['conf-path']}" do 
    cookbook new_resource.ngx_conf_cookbook
    source "nginx.conf.erb"
  end
  template "#{node['nginx']['dir']}/conf/mime.types" do
    cookbook  new_resource.mime_type_cookbook
    source "mime.types.erb"
  end
end
