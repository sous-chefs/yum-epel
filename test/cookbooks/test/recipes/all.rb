# frozen_string_literal: true

volatile_repositories = %w(
  epel-debuginfo
  epel-source
  epel-testing
  epel-testing-debuginfo
  epel-testing-source
  epel-next-debuginfo
  epel-next-source
  epel-next-testing
  epel-next-testing-debuginfo
  epel-next-testing-source
)

yum_epel 'all' do
  repositories :all
  enabled_repositories :all
  repository_options volatile_repositories.to_h { |repo| [repo, { make_cache: false }] }
end
