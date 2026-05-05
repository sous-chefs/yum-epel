# yum_epel_repository

Manages one EPEL repository using Chef Infra's `yum_repository` resource.

## Actions

* `:create` - Creates the repository configuration. This is the default action.
* `:remove` - Removes the repository configuration.

## Properties

* `repo_name` - EPEL repository ID. Defaults to the resource name.
* `baseurl` - Base URL override. Defaults from helper logic.
* `description` - Repository description. Defaults from helper logic.
* `enabled` - Whether the repository is enabled. Defaults from helper logic.
* `gpgcheck` - Whether package GPG checking is enabled. Defaults from helper
  logic.
* `gpgkey` - Repository GPG key URL. Accepts a string, array, or nil. Defaults
  from helper logic.
* `make_cache` - Whether `yum_repository` should build cache. Defaults from
  helper logic.
* `mirrorlist` - Fedora mirrorlist URL. Defaults from helper logic.
* `options` - Additional `yum_repository` properties. Defaults to `{}`.
* `repositoryid` - Repository ID passed to `yum_repository`. Defaults to
  `repo_name`.
* `sslverify` - SSL verification setting. Defaults from helper logic.

## Examples

### Default EPEL repository

```ruby
yum_epel_repository 'epel'
```

### Disabled testing repository

```ruby
yum_epel_repository 'epel-testing'
```

### Internal mirror

```ruby
yum_epel_repository 'epel' do
  mirrorlist nil
  baseurl 'https://internal.example.com/centos/9/os/x86_64'
  sslverify false
end
```
