# frozen_string_literal: true

property :skel, [true, false], default: true, description: 'If the file should be removed from /etc/skel/.bashrc.d'
property :users, Array, default: [], description: 'The users that the file will be removed for in their .bashrc.d dropfolder'
property :filename, String, required: true, description: 'The file name in the dropfolder, should begin with a number for sorting, e.g. 100-myFile'

action :remove do
  remove(new_resource.users, new_resource.skel, new_resource.filename)
end

action_class do
  include CodenamePHP::Bash::Helper
end
