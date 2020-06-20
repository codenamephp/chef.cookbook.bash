# frozen_string_literal: true

user 'create user 1' do
  manage_home true
  username 'user1'
end

codenamephp_bash_manage 'manage bash' do
  users %w[user1 user2]
end

codenamephp_bash_file 'add a file' do
  users %w[user1 user2]
  filename '100-content'
  content 'just some test'
end

codenamephp_bash_cookbook_file 'add a cookbook file' do
  users %w[user1 user2]
  filename '200-file'
  cookbook_file 'some_file'
end

codenamephp_bash_template 'add a template file' do
  users %w[user1 user2]
  filename '300-template'
  source 'some_template'
end
