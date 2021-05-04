# frozen_string_literal: true

unified_mode true
property :skel, [true, false], default: true, description: 'If the file should be added to /etc/skel/.bashrc.d so new users will get it'
property :users, Array, default: [], description: 'The users that will receive the file in their .bashrc.d dropfolder'
property :filename, String, required: true, description: 'The file name in the dropfolder, should begin with a number for sorting, e.g. 100-myFile'
property :content, String, default: '', description: 'The content for the file'

action :add do
  create_file('/etc/skel', 'root', new_resource.filename, new_resource.content) if new_resource.skel
  user_loop(new_resource.users) { |home_folder, user| create_file(home_folder, user, new_resource.filename, new_resource.content) }
end

action :remove do
  remove(new_resource.users, new_resource.skel, new_resource.filename)
end

action_class do
  def create_file(folder, user, filename, file_content)
    file 'create file with content' do
      content <<~FILE
        # Managed by Chef.  Local changes will be overwritten.
        #{file_content}
      FILE
      mode '0770'
      owner user
      group user
      path "#{folder}/.bashrc.d/#{filename}"
    end
  end

  include CodenamePHP::Bash::Helper
end
