name              'yum-epel'
maintainer        'Chef Software, Inc.'
maintainer_email  'cookbooks@chef.io'
license           'Apache-2.0'
description       'Installs and configures the EPEL Yum repository'
version           '3.3.0'
source_url        'https://github.com/chef-cookbooks/yum-epel'
issues_url        'https://github.com/chef-cookbooks/yum-epel/issues'
chef_version      '>= 12.15'

%w(amazon centos oracle redhat scientific zlinux).each do |os|
  supports os
end
