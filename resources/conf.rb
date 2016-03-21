
action :create do
  template "#{node['nginx']['conf-path']}" do 
    cookbook new_resource.ngx_conf_cookbook
    source "nginx.conf.erb"
  end
  template "#{node['nginx']['dir']}/conf/mime.types" do
    cookbook  new_resource.mime_type_cookbook
    source "mime.types.erb"
  end
  template "#{node['nginx']['dir']}/conf/fastcgi.conf" do
    cookbook new_resource.fastcgi_conf_cookbook
    source "fastcgi.conf.erb"
  end
  template "#{node['nginx']['dir']}/conf/scgi_params" do
    cookbook new_resource.scgi_params_cookbook
    source "scgi_params.erb"
  end
  template "#{node['nginx']['dir']}/conf/uwsgi_params" do
    cookbook new_resource.uwsgi_params_cookbook
    source "uwsgi_params.erb"
  end
end
