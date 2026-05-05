# frozen_string_literal: true

yum_epel 'all' do
  repositories :all
  enabled_repositories :all
end
