# Chef Cookbook Bash
[![Build Status](https://travis-ci.org/codenamephp/chef.cookbook.bash.svg?branch=dev)](https://travis-ci.org/codenamephp/chef.cookbook.bash)

Makes sure bash is installed and handles bash configurations

## Requirements

### Supported Platforms

- Debian Stretch

### Chef

- Chef 13.0+

### Cookbook Depdendencies

- [apt][apt_url]
- [bashrc_manager][bashrc_manager_url]

## Usage

Add the cookbook to your Berksfile:

```ruby
cookbook 'codenamephp_bash'
```

Add the tools cookbook to your runlist, e.g. in a role:

```json
{
  "name": "default",
  "chef_type": "role",
  "json_class": "Chef::Role",
  "run_list": [
	  "recipe[codenamephp_bash]"
  ]
}
```
### Attributes

There are currently no attributes.

## Recipes

### Default

The default recipe initializes the bashrc.d folder using the /etc/skel and for each user with uid > 1000 (so all non-system users) that have a user directory. No special 
configs are added. Since all files from the folder are used, you can just add your configs as a template using your own cookbook.

[apt_url]: https://supermarket.chef.io/cookbooks/apt
[bashrc_manager_url]: https://supermarket.chef.io/cookbooks/bashrc_manager