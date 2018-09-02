# Inspec test for recipe codenamephp_mysql::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

control 'bash-1.0' do
  title 'Install bash and create drop folder'
  desc 'make sure bash is installed and that the configs from the drop folder are used'

  describe command('bash') do
    it { should exist }
  end

  describe file('/etc/skel/.bashrc') do
    it { should exist }
    it { should be_file }
    its('content') { should match(%r{# To manually add resources to the bashrc, create a file in the \~\/\.bashrc\.d folder and add your changes there\.}) }
    its('mode') { should cmp '0755' }
    its('owner') { should eq 'root' }
  end

  describe file('/etc/skel/.bashrc.d') do
    it { should exist }
    it { should be_directory }
    its('mode') { should cmp '0755' }
    its('owner') { should eq 'root' }
  end

  describe file('/etc/skel/.bashrc.d/init') do
    it { should exist }
    it { should be_file }
    its('content') { should match(%r{# \~\/\.bashrc: executed by bash\(1\) for non-login shells\.}) }
    its('mode') { should cmp '0755' }
    its('owner') { should eq 'root' }
  end
end
