#
# Cookbook:: codenamephp_dev
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

bashrc_manager 'dummy' do
  user 'vagrant'
  content '# this file exists only to setup the bashrc drop folder'
end
