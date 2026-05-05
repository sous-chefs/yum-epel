# frozen_string_literal: true

require 'spec_helper'
require_relative '../libraries/helpers'

describe YumEpel::Cookbook::Helpers do
  let(:helper_class) do
    Class.new do
      include YumEpel::Cookbook::Helpers

      attr_accessor :node

      def platform?(platform)
        node['platform'] == platform
      end
    end
  end

  let(:helper) { helper_class.new }

  before do
    helper.node = {
      'kernel' => { 'machine' => 'x86_64' },
      'os_release' => { 'name' => 'AlmaLinux' },
      'platform' => 'almalinux',
      'platform_version' => '9.4',
    }
  end

  describe '#yum_epel_release' do
    it 'uses the platform major version by default' do
      expect(helper.yum_epel_release).to eq(9)
    end

    it 'maps Amazon Linux 2023 to EPEL 9' do
      helper.node = helper.node.merge(
        'platform' => 'amazon',
        'platform_version' => '2023'
      )

      expect(helper.yum_epel_release).to eq(9)
    end
  end

  describe '#default_epel_repositories' do
    it 'returns epel for regular Enterprise Linux platforms' do
      expect(helper.default_epel_repositories).to eq(%w(epel))
    end

    it 'adds epel-next for CentOS Stream 9' do
      helper.node = helper.node.merge(
        'os_release' => { 'name' => 'CentOS Stream' },
        'platform' => 'centos',
        'platform_version' => '9'
      )

      expect(helper.default_epel_repositories).to eq(%w(epel epel-next))
    end

    it 'does not add epel-next for CentOS Stream 10' do
      helper.node = helper.node.merge(
        'os_release' => { 'name' => 'CentOS Stream' },
        'platform' => 'centos',
        'platform_version' => '10'
      )

      expect(helper.default_epel_repositories).to eq(%w(epel))
    end
  end

  describe '#epel_repository_defaults' do
    it 'preserves the standard epel mirrorlist URL' do
      expect(helper.epel_repository_defaults('epel')[:mirrorlist]).to eq('https://mirrors.fedoraproject.org/mirrorlist?repo=epel-9&arch=$basearch')
    end

    it 'preserves the legacy testing source URL pattern' do
      expect(helper.epel_repository_defaults('epel-testing-source')[:mirrorlist]).to eq('https://mirrors.fedoraproject.org/mirrorlist?repo=testing-source-epel9&arch=$basearch')
    end

    it 'uses the EPEL 10 minor stream testing mirrorlist URL pattern' do
      helper.node = helper.node.merge(
        'os_release' => { 'name' => 'CentOS Stream' },
        'platform' => 'centos',
        'platform_version' => '10'
      )

      expect(helper.epel_repository_defaults('epel-testing')[:mirrorlist]).to eq('https://mirrors.fedoraproject.org/mirrorlist?repo=epel-z-testing-10&arch=$basearch')
      expect(helper.epel_repository_defaults('epel-testing-debuginfo')[:mirrorlist]).to eq('https://mirrors.fedoraproject.org/mirrorlist?repo=epel-z-testing-debug-10&arch=$basearch')
      expect(helper.epel_repository_defaults('epel-testing-source')[:mirrorlist]).to eq('https://mirrors.fedoraproject.org/mirrorlist?repo=epel-z-testing-source-10&arch=$basearch')
    end
  end
end
