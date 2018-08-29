#
# Cookbook:: codenamephp_dev
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

package 'bash'

bashrc_manager 'dummy' do
  user node['codenamephp_bash']['user']
  content '# this file exists only to setup the bashrc drop folder'
end
