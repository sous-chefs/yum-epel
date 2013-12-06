# Encoding: utf-8

default['yum']['epel-debuginfo']['repositoryid'] = 'epel-debuginfo'

case node['platform_version'].to_i
when 5
  default['yum']['epel-debuginfo']['description'] = 'Extra Packages for Enterprise Linux 5 - $basearch - Debug'
  default['yum']['epel-debuginfo']['mirrorlist'] = 'http://mirrors.fedoraproject.org/mirrorlist?repo=epel-debug-5&arch=$basearch'
  default['yum']['epel-debuginfo']['gpgkey'] = 'http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL'
when 6
  default['yum']['epel-debuginfo']['description'] = 'Extra Packages for Enterprise Linux 6 - $basearch - Debug'
  default['yum']['epel-debuginfo']['mirrorlist'] = 'https://mirrors.fedoraproject.org/metalink?repo=epel-debug-6&arch=$basearch'
  default['yum']['epel-debuginfo']['gpgkey'] = 'http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-6'
end

default['yum']['epel-debuginfo']['failovermethod'] = 'priority'
default['yum']['epel-debuginfo']['enabled'] = false
default['yum']['epel-debuginfo']['gpgcheck'] = true