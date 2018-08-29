# Inspec test for recipe codenamephp_mysql::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

control 'bash-1.0' do
  title 'Install bash and create drop folder'
  desc 'make sure bash is installed and that the configs from the drop folder are used'

  describe command('bash') do
    it { should exist }
  end
end
