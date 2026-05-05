# frozen_string_literal: true

require 'spec_helper'

describe 'yum_epel_repository' do
  step_into :yum_epel_repository
  platform 'almalinux', '9'

  context 'with the epel repository' do
    recipe do
      yum_epel_repository 'epel'
    end

    it do
      is_expected.to create_yum_repository('epel').with(
        description: 'Extra Packages for 9 - $basearch',
        enabled: true,
        gpgcheck: true,
        gpgkey: 'https://download.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-9',
        make_cache: true,
        mirrorlist: 'https://mirrors.fedoraproject.org/mirrorlist?repo=epel-9&arch=$basearch',
        repositoryid: 'epel'
      )
    end
  end

  context 'with an optional repository' do
    recipe do
      yum_epel_repository 'epel-testing'
    end

    it { is_expected.to create_yum_repository('epel-testing').with(enabled: false) }
  end

  context 'with explicit overrides' do
    recipe do
      yum_epel_repository 'epel' do
        baseurl 'https://internal.example.com/centos/9/os/x86_64'
        enabled false
        mirrorlist nil
        options(
          sslverify: false
        )
      end
    end

    it do
      is_expected.to create_yum_repository('epel').with(
        baseurl: 'https://internal.example.com/centos/9/os/x86_64',
        enabled: false,
        sslverify: false
      )
    end
  end

  context 'with action remove' do
    recipe do
      yum_epel_repository 'epel' do
        action :remove
      end
    end

    it { is_expected.to remove_yum_repository('epel') }
  end
end
