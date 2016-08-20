name 'yum-epel'
maintainer 'Chef Software, Inc.'
maintainer_email 'cookbooks@chef.io'
license 'Apache 2.0'
description 'Installs and configures the EPEL Yum repository'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.7.1'

depends 'yum', '>= 3.6.3'

%w(amazon centos oracle redhat scientific zlinux).each do |os|
  supports os
end

source_url 'https://github.com/chef-cookbooks/yum-epel' if respond_to?(:source_url)
issues_url 'https://github.com/chef-cookbooks/yum-epel/issues' if respond_to?(:issues_url)
