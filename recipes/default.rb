#
# Cookbook:: codenamephp_bash
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

include_recipe 'apt'
package 'bash'

directory 'create .bashrc.d folder in /etc/skel' do
  path '/etc/skel/.bashrc.d'
  mode 0o755
end

file 'copy default .bashrc to init in dropfolder' do
  path '/etc/skel/.bashrc.d/init'
  mode 0o755
  content(lazy { ::File.open('/etc/skel/.bashrc').read })
  action :create_if_missing
end

template '/etc/skel/.bashrc' do
  source '.bashrc.erb'
  mode 0o755
end

node['etc']['passwd'].each do |user, data|
  next unless data['uid'].to_i >= 1000 && File.directory?(data['dir'])

  bashrc_manager "init bashrc.d for user #{user}" do
    user user
    content '# this file exists only to setup the bashrc drop folder'
  end
end
