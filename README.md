# Chef Cookbook Bash
[![Build Status](https://travis-ci.org/codenamephp/chef.cookbook.bash.svg?branch=dev)](https://travis-ci.org/codenamephp/chef.cookbook.bash)

Makes sure bash is installed and handles bash configurations

## Requirements

### Supported Platforms

- Debian Stretch

### Chef

- Chef 13.0+

### Cookbook Depdendencies


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

## Recipes

### Default
