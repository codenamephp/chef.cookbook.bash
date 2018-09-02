#
# Cookbook:: codenamephp_bash
# Spec:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'codenamephp_bash::default' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new do |node|
        node.override['etc']['passwd'] = []
      end.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'includes the apt cookbook' do
      expect(chef_run).to include_recipe('apt')
    end

    it 'installs bash from package' do
      expect(chef_run).to install_package('bash')
    end

    it 'copies the default .bashrc to init file in dropfolder' do
      allow(File).to receive(:open).and_call_original
      allow(File).to(receive(:open).with('/etc/skel/.bashrc') do
        double = double(File)
        allow(double).to receive(:read).and_return 'some content'
        double
      end)

      expect(chef_run).to create_if_missing_file('copy default .bashrc to init in dropfolder').with(
        path: '/etc/skel/.bashrc.d/init',
        mode: 0o755,
        content: 'some content'
      )
    end

    it 'updates the skel .bashrc with template content' do
      expect(chef_run).to create_template('/etc/skel/.bashrc').with(source: '.bashrc.erb', mode: 0o755)
    end
  end

  context 'When users were detected' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new do |node|
        node.override['etc']['passwd'] = {
          'user1' => { 'dir' => '/home/user1', 'uid' => 1000, 'gid' => 123 },
          'user2' => { 'dir' => '/home/user2', 'uid' => 1001, 'gid' => 456 },
          'user3' => { 'dir' => '/home/user3', 'uid' => 500, 'gid' => 789 },
          'user4' => { 'dir' => '/home/user4', 'uid' => 1002, 'gid' => 789 }
        }
      end.converge(described_recipe)
    end

    before(:each) do
      allow(File).to receive(:directory?).with(anything).and_call_original
      allow(File).to receive(:directory?).with('/home/user1').and_return true
      allow(File).to receive(:directory?).with('/home/user2').and_return true
      allow(File).to receive(:directory?).with('/home/user3').and_return true
      allow(File).to receive(:directory?).with('/home/user4').and_return false
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'executes the resource for every user with a home directory' do
      expect(chef_run).to add_bashrc_manager('init bashrc.d for user user1').with(
        user: 'user1',
        content: '# this file exists only to setup the bashrc drop folder'
      )
      expect(chef_run).to add_bashrc_manager('init bashrc.d for user user2').with(
        user: 'user2',
        content: '# this file exists only to setup the bashrc drop folder'
      )
    end
  end
end
