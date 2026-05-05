# frozen_string_literal: true

require 'spec_helper'

describe 'yum_epel' do
  step_into :yum_epel

  context 'on AlmaLinux 9' do
    platform 'almalinux', '9'

    recipe do
      yum_epel 'default'
    end

    %w(
      /etc/yum.repos.d/epel-testing.repo
      /etc/yum.repos.d/epel-next.repo
      /etc/yum.repos.d/epel-next-testing.repo
    ).each do |repo_file|
      it { is_expected.to delete_file(repo_file) }
    end

    it { is_expected.to_not delete_file('/etc/yum.repos.d/epel.repo') }
    it { is_expected.to create_yum_epel_repository('epel').with(enabled: true) }
    it { is_expected.to_not create_yum_epel_repository('epel-next') }
  end

  context 'on CentOS Stream 9' do
    platform 'almalinux', '9'

    automatic_attributes['os_release'] = { 'name' => 'CentOS Stream' }

    recipe do
      yum_epel 'default'
    end

    it { is_expected.to create_yum_epel_repository('epel').with(enabled: true) }
    it { is_expected.to create_yum_epel_repository('epel-next').with(enabled: true) }
  end

  context 'with all repositories enabled' do
    platform 'almalinux', '9'

    automatic_attributes['os_release'] = { 'name' => 'CentOS Stream' }

    recipe do
      yum_epel 'all' do
        repositories :all
        enabled_repositories :all
      end
    end

    it { is_expected.to create_yum_epel_repository('epel-testing-source').with(enabled: true) }
    it { is_expected.to create_yum_epel_repository('epel-next-testing-source').with(enabled: true) }
  end

  context 'with action remove' do
    platform 'almalinux', '9'

    recipe do
      yum_epel 'default' do
        action :remove
      end
    end

    it { is_expected.to remove_yum_epel_repository('epel') }
  end
end
