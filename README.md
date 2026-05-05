# yum-epel Cookbook

[![Cookbook Version](https://img.shields.io/cookbook/v/yum-epel.svg)](https://supermarket.chef.io/cookbooks/yum-epel)
[![CI State](https://github.com/sous-chefs/yum-epel/workflows/ci/badge.svg)](https://github.com/sous-chefs/yum-epel/actions?query=workflow%3Aci)
[![OpenCollective](https://opencollective.com/sous-chefs/backers/badge.svg)](#backers)
[![OpenCollective](https://opencollective.com/sous-chefs/sponsors/badge.svg)](#sponsors)
[![License](https://img.shields.io/badge/License-Apache%202.0-green.svg)](https://opensource.org/licenses/Apache-2.0)

Extra Packages for Enterprise Linux (or EPEL) is a Fedora Special Interest Group that creates, maintains, and manages a high quality set of additional packages for Enterprise Linux.

The yum-epel cookbook provides custom resources that wrap Chef Infra's `yum_repository` resource for the default repository IDs shipped by `epel-release` and `epel-next-release`.

For migration details from the legacy recipe and attribute API, see [migration.md](migration.md).

Below is a table showing which repository IDs are managed by the cookbook resources:

| Repo ID                        | EL 8 | EL 9 | EL 10 | CentOS Stream 9 |
| ------------------------------ | :--: | :--: | :---: | :-------------: |
| epel                           | yes  | yes  | yes   | yes             |
| epel-debuginfo                 | yes  | yes  | yes   | yes             |
| epel-next                      | no   | no   | no    | yes             |
| epel-next-debuginfo            | no   | no   | no    | yes             |
| epel-next-source               | no   | no   | no    | yes             |
| epel-next-testing              | no   | no   | no    | yes             |
| epel-next-testing-debug        | no   | no   | no    | yes             |
| epel-next-testing-source       | no   | no   | no    | yes             |
| epel-source                    | yes  | yes  | yes   | yes             |
| epel-testing                   | yes  | yes  | yes   | yes             |
| epel-testing-debuginfo         | yes  | yes  | yes   | yes             |
| epel-testing-source            | yes  | yes  | yes   | yes             |

## Requirements

### Platforms

* AlmaLinux 8+
* Amazon Linux 2023+
* CentOS Stream 9+
* Oracle Linux 8+
* Red Hat Enterprise Linux 8+
* Rocky Linux 8+

### Chef

* Chef 15.3+

## Maintainers

This cookbook is maintained by the Sous Chefs. The Sous Chefs are a community of Chef cookbook maintainers working together to maintain important cookbooks. If you’d like to know more please visit [sous-chefs.org](https://sous-chefs.org/) or come chat with us on the Chef Community Slack in [#sous-chefs](https://chefcommunity.slack.com/messages/C2V7B88SF).

### Cookbooks

* none

## Resources

* [yum_epel](documentation/yum-epel_yum_epel.md)
* [yum_epel_repository](documentation/yum-epel_yum_epel_repository.md)

## Usage Example

Manage the default EPEL repositories. By default the `epel` repository is enabled. On CentOS Stream 9, `epel-next` is also enabled.

```ruby
yum_epel 'default'
```

Disable the `epel` repository while keeping it managed.

```ruby
yum_epel 'default' do
  disabled_repositories ['epel']
end
```

Uncommonly used repository IDs are not managed by default. To manage and enable all supported repository IDs for the platform:

```ruby
yum_epel 'all' do
  repositories :all
  enabled_repositories :all
end
```

## More Examples

Point the epel repositories at an internally hosted server.

```ruby
yum_epel_repository 'epel' do
  mirrorlist nil
  baseurl 'https://internal.example.com/centos/9/os/x86_64'
  sslverify false
end
```

## Contributors

This project exists thanks to all the people who [contribute.](https://opencollective.com/sous-chefs/contributors.svg?width=890&button=false)

### Backers

Thank you to all our backers!

![https://opencollective.com/sous-chefs#backers](https://opencollective.com/sous-chefs/backers.svg?width=600&avatarHeight=40)

### Sponsors

Support this project by becoming a sponsor. Your logo will show up here with a link to your website.

![https://opencollective.com/sous-chefs/sponsor/0/website](https://opencollective.com/sous-chefs/sponsor/0/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/1/website](https://opencollective.com/sous-chefs/sponsor/1/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/2/website](https://opencollective.com/sous-chefs/sponsor/2/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/3/website](https://opencollective.com/sous-chefs/sponsor/3/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/4/website](https://opencollective.com/sous-chefs/sponsor/4/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/5/website](https://opencollective.com/sous-chefs/sponsor/5/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/6/website](https://opencollective.com/sous-chefs/sponsor/6/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/7/website](https://opencollective.com/sous-chefs/sponsor/7/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/8/website](https://opencollective.com/sous-chefs/sponsor/8/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/9/website](https://opencollective.com/sous-chefs/sponsor/9/avatar.svg?avatarHeight=100)
