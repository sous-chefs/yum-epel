# Encoding: utf-8

require 'spec_helper'

describe 'yum-epel::default' do
  context 'yum-epel::default uses default attributes' do
    let(:chef_run) { ChefSpec::Runner.new(:step_into => ['yum_repository']).converge(described_recipe) }

    # Make sure base recipe removes default configurations. We will
    # recreate their contents over multiple files later.

    it 'creates yum_repository[epel]' do
      expect(chef_run).to create_yum_repository('epel')
    end

    it 'creates yum_repository[epel-debuginfo]' do
      expect(chef_run).to create_yum_repository('epel-debuginfo')
    end

    it 'creates yum_repository[epel-source]' do
      expect(chef_run).to create_yum_repository('epel-source')
    end

    it 'creates yum_repository[epel-testing]' do
      expect(chef_run).to create_yum_repository('epel-testing')
    end

    it 'creates yum_repository[epel-testing-debuginfo]' do
      expect(chef_run).to create_yum_repository('epel-testing-debuginfo')
    end

    it 'creates yum_repository[epel-testing-source]' do
      expect(chef_run).to create_yum_repository('epel-testing-source')
    end

    it 'steps into yum_repository and creates template[/etc/yum.repos.d/epel.repo]' do
      expect(chef_run).to render_file('/etc/yum.repos.d/epel.repo')
    end

    it 'steps into yum_repository and creates template[/etc/yum.repos.d/epel-debuginfo.repo]' do
      expect(chef_run).to render_file('/etc/yum.repos.d/epel-debuginfo.repo')
    end

    it 'steps into yum_repository and creates template[/etc/yum.repos.d/epel-source.repo]' do
      expect(chef_run).to render_file('/etc/yum.repos.d/epel-source.repo')
    end

    it 'steps into yum_repository and creates template[/etc/yum.repos.d/epel-testing.repo]' do
      expect(chef_run).to render_file('/etc/yum.repos.d/epel-testing.repo')
    end

    it 'steps into yum_repository and creates template[/etc/yum.repos.d/epel-testing-debuginfo.repo]' do
      expect(chef_run).to render_file('/etc/yum.repos.d/epel-testing-debuginfo.repo')
    end

    it 'steps into yum_repository and creates template[/etc/yum.repos.d/epel-testing-source.repo]' do
      expect(chef_run).to render_file('/etc/yum.repos.d/epel-testing-source.repo')
    end

  end
end
