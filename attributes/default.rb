default['yum-epel']['repos'] =
  value_for_platform(
    %w(redhat centos oracle) => {
      '>= 8.0' => epel_8_repos,
      '~> 7.0' =>
        %w(
          epel
          epel-debuginfo
          epel-source
          epel-testing
          epel-testing-debuginfo
          epel-testing-source
        ),
    },
    'amazon' => {
      'default' =>
        %w(
          epel
          epel-debuginfo
          epel-source
          epel-testing
          epel-testing-debuginfo
          epel-testing-source
        ),
      },
    # No-op on non-yum systems
    'default' => []
  )
