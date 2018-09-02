name 'codenamephp_bash'
maintainer 'Bastian Schwarz'
maintainer_email 'bastian@codename-php.de'
license 'Apache-2.0'
description 'Makes sure bash is installed and handles bash configurations'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.0.1'
chef_version '>= 13.0' if respond_to?(:chef_version)
issues_url 'https://github.com/codenamephp/chef.cookbook.bash/issues' if respond_to?(:issues_url)
source_url 'https://github.com/codenamephp/chef.cookbook.bash' if respond_to?(:source_url)

supports 'debian', '~>9.1'

depends 'apt', '~> 7.0'
depends 'bashrc_manager', '~> 1.0'
