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
    end
  end
end
