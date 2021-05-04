# frozen_string_literal: true

unified_mode true
property :skel, [true, false], default: true, description: 'Manages the /etc/skel/.bashrc.d and .bashrc so new users will get the dropfolder'
property :users, Array, default: [], description: 'The users that will receive the .bashrc.d dropfolder'

action :manage do
  apt_update
  package 'bash'

  init('/etc/skel', 'root') if new_resource.skel

  user_loop(new_resource.users) { |home_folder, user| init(home_folder, user) }
end

action_class do
  def init(folder, user)
    directory 'create .bashrc.d folder' do
      path "#{folder}/.bashrc.d"
      mode '0770'
      owner user
      group user
    end

    file 'copy default .bashrc to init in dropfolder' do
      path "#{folder}/.bashrc.d/000-init"
      mode '0770'
      owner user
      group user
      content(lazy { ::File.read("#{folder}/.bashrc") })
      action :create_if_missing
    end

    template 'setup include file as new .bashrc' do
      path "#{folder}/.bashrc"
      source '.bashrc.erb'
      cookbook 'codenamephp_bash'
      mode '0770'
      owner user
      group user
    end
  end

  include CodenamePHP::Bash::Helper
end
