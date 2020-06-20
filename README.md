# Chef Cookbook Bash
[![Build Status](https://travis-ci.com/codenamephp/chef.cookbook.bash.svg?branch=master)](https://travis-ci.com/codenamephp/chef.cookbook.bash)

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

There are no recipes but several resources. A basic usage could look like:

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

Use these resources in your recipes. The manage resource has to be called first so the dropfolders will be created. 
The other resources can be used to add files to the dropfolders. If a user
does not exist it will just be skipped and no files and folders will be created.

The file resources are primarily for convenience since the handle skel and users and do user and directory checks. If you have advanced requirements like template variables you can always just place your files yourself into the .bashrc.d folder using regular chef resources.

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

### File
This resource adds a new file with the given content to the dropfolder for all given users and skel.

#### Properties

- `skel`: Boolean to enable/disable the management of /etc/skel, defaults to true
- `users`: Array of usernames that will be managed, defaults to an empty array
- `filename`: The filename inside the .bashrc.d folder as string, should begin with a number xxx- for sorting
- `content`: The content as string that of the created file

#### Examples

```ruby
# Minimal properties
codenamephp_bash_file 'only for skel' do
  filename '100-example'
  content 'some bash commands'
end

# For users and not skel
codenamephp_bash_file 'add file' do
  skel false
  users %w[user1 user2]
  filename '100-example'
  content 'some bash commands'
end
```

### Cookbook File
This resource adds a cookbook file for all given users and skel.

####  Properties

- `skel`: Boolean to enable/disable the management of /etc/skel, defaults to true
- `users`: Array of usernames that will be managed, defaults to an empty array
- `filename`: The filename inside the .bashrc.d folder as string, should begin with a number xxx- for sorting
- `cookbook_file`: The name of the cookbook file to add, this file must be present in your cookbook

#### Examples

```ruby
# Minimal properties
codenamephp_bash_cookbook_file 'only for skel' do
  filename '100-example'
  cookbook_file 'some/file'
end

# For users and not skel
codenamephp_bash_cookbook_file 'add file' do
  skel false
  users %w[user1 user2]
  filename '100-example'
  cookbook_file 'some/file'
end
```

### Template
This resource adds a new file using chef templates for all given users and skel.

#### Properties

- `skel`: Boolean to enable/disable the management of /etc/skel, defaults to true
- `users`: Array of usernames that will be managed, defaults to an empty array
- `filename`: The filename inside the .bashrc.d folder as string, should begin with a number xxx- for sorting
- `source`: The source template to use. The template must be present in your cookbook

#### Examples

```ruby
# Minimal properties
codenamephp_bash_template 'only for skel' do
  filename '100-example'
  source 'some/file'
end

# For users and not skel
codenamephp_bash_template 'add file' do
  skel false
  users %w[user1 user2]
  filename '100-example'
  source 'some/file'
end
```

### Remove File
This resource removes the given file for all users and skel. This works for all files including cookbook files and templates.

#### Properties

- `skel`: Boolean to enable/disable the management of /etc/skel, defaults to true
- `users`: Array of usernames that will be managed, defaults to an empty array
- `filename`: The filename inside the .bashrc.d folder as string, should begin with a number xxx- for sorting

#### Examples

```ruby
# Minimal properties
codenamephp_bash_remove_file 'only for skel' do
  filename '100-example'
  source 'some/file'
end

# For users and not skel
codenamephp_bash_remove_file 'remove file' do
  skel false
  users %w[user1 user2]
  filename '100-example'
end
```
