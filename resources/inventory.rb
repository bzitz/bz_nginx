action :collect do
  nginx_args = []
  #configured_args = Mixlib::ShellOut.new(".#{node['nginx']['sbin-path']} -V")
  nginx_cflags = Mixlib::ShellOut.new("./nginx -V", :cwd => '/usr/local/nginx/sbin')
  nginx_cflags.run_command

  nginx_cflags.stderr.each_line do |line|
    case line
    when /nginx version/
      node.run_state['installed_version'] = line.split(/\/ */)[1].chomp
    when /configure arguments/
      node.run_state['compiled_flags'] = line.split(/: */)[1].split(' ')
    end
  end
end

