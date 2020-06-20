# Chef Cookbook Bash
[![Build Status](https://travis-ci.org/codenamephp/chef.cookbook.bash.svg?branch=dev)](https://travis-ci.org/codenamephp/chef.cookbook.bash)

Makes sure bash is installed and handles bash configurations

## Requirements

### Supported Platforms

- Debian

### Chef

- Chef 13.0+

## Usage

Add the cookbook to your Berksfile or metadata.rb:

```ruby
cookbook 'codenamephp_bash'
```

There are no recipies but several resources. A basic usage could look like:

```ruby
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
```

Use this resources in your recipies. The manage resource has to be called first so the dropfolders will be created. 
The other resources can be used to add files to the dropfolders. If a user
does not exist it will just be skipped and no files and folders will be created.

## Resources

### Manage
This resources initializes the bash config management by createing a .bashrc.d dropfolder, moving the current .bashrc to .bashrc.d/000-init and replaces the .bashrc with a file that sources all files within the .bashrc.d folder

By default, this will also be done in the /etc/skel folder so new users that will be created will be created with the same settings. This can be useful when the users are "not known" or created dynamicly via a databag.

#### Actions

- `manage`: Creates the folder and initializes the .bashrc

#### Properties

- `skel`: Boolean to enable/disable the management of /etc/skel, defaults to true
- `users`: Array of usernames that will be managed, defaults to an empty array

#### Examples

```ruby
# Minimal properties
codenamephp_bash_manage 'manage bash'

# For users and not skel
codenamephp_bash_manage 'manage bash' do
  skel false
  users %w[user1 user2]
end
```