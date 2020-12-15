# yum-epel Cookbook

[![Build Status](https://travis-ci.org/chef-cookbooks/yum-epel.svg?branch=master)](http://travis-ci.org/chef-cookbooks/yum-epel) [![Cookbook Version](https://img.shields.io/cookbook/v/yum-epel.svg)](https://supermarket.chef.io/cookbooks/yum-epel)

Extra Packages for Enterprise Linux (or EPEL) is a Fedora Special Interest Group that creates, maintains, and manages a high quality set of additional packages for Enterprise Linux, including, but not limited to, Red Hat Enterprise Linux (RHEL), CentOS and Scientific Linux (SL), Oracle Linux (OL).

The yum-epel cookbook takes over management of the default repositoryids shipped with epel-release.

Below is a table showing which repositoryids we manage that are shipped by default via the epel-release package:

| Repo ID                        | EL 7             | EL 8             |
| ------------------------------ | :--------------: | :--------------: |
| epel                           |:heavy_check_mark:|:heavy_check_mark:|
| epel-debuginfo                 |:heavy_check_mark:|:heavy_check_mark:|
| epel-modular                   |       :x:        |:heavy_check_mark:|
| epel-modular-debuginfo         |       :x:        |:heavy_check_mark:|
| epel-modular-source            |       :x:        |:heavy_check_mark:|
| epel-playground                |       :x:        |:heavy_check_mark:|
| epel-playground-debuginfo      |       :x:        |:heavy_check_mark:|
| epel-playground-source         |       :x:        |:heavy_check_mark:|
| epel-source                    |:heavy_check_mark:|:heavy_check_mark:|
| epel-testing                   |:heavy_check_mark:|:heavy_check_mark:|
| epel-testing-debuginfo         |:heavy_check_mark:|:heavy_check_mark:|
| epel-testing-modular           |       :x:        |:heavy_check_mark:|
| epel-testing-modular-debuginfo |       :x:        |:heavy_check_mark:|
| epel-testing-modular-source    |       :x:        |:heavy_check_mark:|
| epel-testing-source            |:heavy_check_mark:|:heavy_check_mark:|

## Requirements

### Platforms

- RHEL/CentOS and derivatives

### Chef

- Chef 12.15+

### Cookbooks

- none

## Attributes

See individual repository attribute files for defaults.

## Recipes

- `yum-epel::default` Generates `yum_repository` configs for the standard EPEL repositories. By default the `epel` repository is enabled.

## Usage Example

To disable the epel repository through a Role or Environment definition

```
default_attributes(
  :yum => {
    :epel => {
      :enabled => {
        false
       }
     }
   }
 )
```

Uncommonly used repositoryids are not managed by default. This is speeds up integration testing pipelines by avoiding yum-cache builds that nobody cares about. To enable the epel-testing repository with a wrapper cookbook, place the following in a recipe:

```ruby
node.default['yum']['epel-testing']['enabled'] = true
node.default['yum']['epel-testing']['managed'] = true
include_recipe 'yum-epel'
```

## More Examples

Point the epel repositories at an internally hosted server.

```ruby
node.default['yum']['epel']['enabled'] = true
node.default['yum']['epel']['mirrorlist'] = nil
node.default['yum']['epel']['baseurl'] = 'https://internal.example.com/centos/7/os/x86_64'
node.default['yum']['epel']['sslverify'] = false

include_recipe 'yum-epel'
```

## License & Authors

**Author:** Cookbook Engineering Team ([cookbooks@chef.io](mailto:cookbooks@chef.io))

**Copyright:** 2011-2016, Chef Software, Inc.

```
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
