# frozen_string_literal: true

user 'create user 1' do
  manage_home true
  username 'user1'
end
user 'create user 3' do
  manage_home true
  username 'user3'
end

codenamephp_bash_manage 'manage bash' do
  users %w[user1 user2 user3]
end

codenamephp_bash_file 'add a file' do
  users %w[user1 user2 user3]
  filename '100-content'
  content 'just some test'
end

codenamephp_bash_cookbook_file 'add a cookbook file' do
  users %w[user1 user2 user3]
  filename '200-file'
  cookbook_file 'some_file'
  cookbook 'test'
end

codenamephp_bash_template 'add a template file' do
  users %w[user1 user2 user3]
  filename '300-template'
  source 'some_template'
  cookbook 'test'
end

codenamephp_bash_file 'add a file' do
  users %w[user3]
  filename '400-content'
  content 'just some test'
end
codenamephp_bash_file 'add a file' do
  users %w[user3]
  filename '500-content'
  content 'just some test'
end

codenamephp_bash_remove_file 'remove a file' do
  users %w[user3]
  filename '400-content'
end
codenamephp_bash_remove_file 'remove a file' do
  users %w[user3]
  filename '500-content'
  skel false
end
