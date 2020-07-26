# frozen_string_literal: true

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
    its('content') { should match(%r{# To manually add resources to the bashrc, create a file in the ~/\.bashrc\.d folder and add your changes there\.}) }
    its('mode') { should cmp '0770' }
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
  end

  describe file('/etc/skel/.bashrc.d') do
    it { should exist }
    it { should be_directory }
    its('mode') { should cmp '0770' }
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
  end

  describe file('/etc/skel/.bashrc.d/000-init') do
    it { should exist }
    it { should be_file }
    its('content') { should match(%r{# ~/\.bashrc: executed by bash\(1\) for non-login shells\.}) }
    its('mode') { should cmp '0770' }
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
  end

  describe file('/etc/skel/.bashrc.d/100-content') do
    it { should exist }
    it { should be_file }
    its('content') { should match('just some test') }
    its('mode') { should cmp '0770' }
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
  end

  describe file('/etc/skel/.bashrc.d/200-file') do
    it { should exist }
    it { should be_file }
    its('content') { should match('just some test file') }
    its('mode') { should cmp '0770' }
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
  end

  describe file('/etc/skel/.bashrc.d/300-template') do
    it { should exist }
    it { should be_file }
    its('content') { should match('just some test template') }
    its('mode') { should cmp '0770' }
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
  end
  describe file('/etc/skel/.bashrc.d/400-content') do
    it { should_not exist }
  end
  describe file('/etc/skel/.bashrc.d/500-content') do
    it { should exist }
  end

  describe file('/home/user1/.bashrc') do
    it { should exist }
    it { should be_file }
    its('content') { should match(%r{# To manually add resources to the bashrc, create a file in the ~/\.bashrc\.d folder and add your changes there\.}) }
    its('mode') { should cmp '0770' }
    its('owner') { should eq 'user1' }
    its('group') { should eq 'user1' }
  end

  describe file('/home/user1/.bashrc.d') do
    it { should exist }
    it { should be_directory }
    its('mode') { should cmp '0770' }
    its('owner') { should eq 'user1' }
    its('group') { should eq 'user1' }
  end

  describe file('/home/user1/.bashrc.d/000-init') do
    it { should exist }
    it { should be_file }
    its('content') { should match(%r{# ~/\.bashrc: executed by bash\(1\) for non-login shells\.}) }
    its('mode') { should cmp '0770' }
    its('owner') { should eq 'user1' }
    its('group') { should eq 'user1' }
  end

  describe file('/home/user1/.bashrc.d/100-content') do
    it { should exist }
    it { should be_file }
    its('content') { should match('just some test') }
    its('mode') { should cmp '0770' }
    its('owner') { should eq 'user1' }
    its('group') { should eq 'user1' }
  end

  describe file('/home/user1/.bashrc.d/200-file') do
    it { should exist }
    it { should be_file }
    its('content') { should match('just some test file') }
    its('mode') { should cmp '0770' }
    its('owner') { should eq 'user1' }
    its('group') { should eq 'user1' }
  end

  describe file('/home/user1/.bashrc.d/300-template') do
    it { should exist }
    it { should be_file }
    its('content') { should match('just some test template') }
    its('mode') { should cmp '0770' }
    its('owner') { should eq 'user1' }
    its('group') { should eq 'user1' }
  end
  describe file('/home/user1/.bashrc.d/400-content') do
    it { should_not exist }
  end

  describe file('/home/user2/.bashrc') do
    it { should_not exist }
  end
  describe file('/home/user2/.bashrc.d') do
    it { should_not exist }
  end
  describe file('/home/user2/.bashrc.d/000-init') do
    it { should_not exist }
  end
  describe file('/home/user2/.bashrc.d/100-content') do
    it { should_not exist }
  end
  describe file('/home/user2/.bashrc.d/200-file') do
    it { should_not exist }
  end
  describe file('/home/user2/.bashrc.d/300-template') do
    it { should_not exist }
  end
  describe file('/home/user2/.bashrc.d/400-content') do
    it { should_not exist }
  end

  describe file('/home/user3/.bashrc') do
    it { should exist }
  end
  describe file('/home/user3/.bashrc.d') do
    it { should exist }
  end
  describe file('/home/user3/.bashrc.d/000-init') do
    it { should exist }
  end
  describe file('/home/user3/.bashrc.d/100-content') do
    it { should exist }
  end
  describe file('/home/user3/.bashrc.d/200-file') do
    it { should exist }
  end
  describe file('/home/user3/.bashrc.d/300-template') do
    it { should exist }
  end
  describe file('/home/user3/.bashrc.d/400-content') do
    it { should_not exist }
  end
  describe file('/home/user3/.bashrc.d/500-content') do
    it { should_not exist }
  end
end
