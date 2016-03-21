action :create do
  directory node['nginx']['dir'] do 
    owner 'root'
    group 'root'
    mode  '0755'
  end


  node['nginx']['common_dirs'].each do |key,value|
    case key
    when "ssl"
      dir_perms = '0600'
    else
      dir_perms = '0755'
    end
    directory value do
      owner 'root'
      group 'root'
      mode  dir_perms
    end
  end
  file node['nginx']['pid-path'] do
    owner 'root'
    group 'root'
    mode  '0755'
    action :touch
  end
end
