# frozen_string_literal: true

property :skel, [true, false], default: true, description: 'If the file should be added to /etc/skel/.bashrc.d so new users will get it'
property :users, Array, default: [], description: 'The users that will receive the file in their .bashrc.d dropfolder'
property :filename, String, required: true, description: 'The file name in the dropfolder, should begin with a number for sorting, e.g. 100-myFile'
property :cookbook_file, String, required: true, description: 'The cookbook_file to use as source for the cookbook_file'

action :add do
  create_file('/etc/skel', 'root', new_resource.filename, new_resource.cookbook_file) if new_resource.skel
  user_loop(new_resource.users) { |home_folder, user| create_file(home_folder, user, new_resource.filename, new_resource.cookbook_file) }
end

action_class do
  def create_file(folder, user, filename, cookbook_file)
    cookbook_file 'create file from cookbook_file' do
      mode '0640'
      owner user
      path "#{folder}/.bashrc.d/#{filename}"
      source cookbook_file
    end
  end

  include CodenamePHP::Bash::Helper
end
