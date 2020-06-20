# frozen_string_literal: true

require 'mixlib/shellout'

# The CodenamePHP Namespace
module CodenamePHP
  # The Bash Cookbook Namespace
  module Bash
    # Helper to share code between resources
    module Helper
      def user_loop(users)
        users.each do |user|
          next if Mixlib::ShellOut.new("getent passwd #{user}").run_command.error?

          home_folder = ::Dir.home(user)
          yield(home_folder, user) if Dir.exist?(home_folder)
        end
      end

      def delete_file(folder, filename)
        file 'delete file' do
          path "#{folder}/.bashrc.d/#{filename}"
          action :delete
        end
      end

      def delete_file_for_users(users, filename)
        user_loop(users) { |home_folder| delete_file(home_folder, filename) }
      end

      def remove(users, skel, filename)
        delete_file('/etc/skel', filename) if skel
        delete_file_for_users(users, filename)
      end
    end
  end
end
