# Migration Guide

This release is a full custom resource migration. The legacy `yum-epel::default` recipe and `node['yum']` / `node['yum-epel']` attributes have been removed.

## What Changed

* Use `yum_epel` instead of `include_recipe 'yum-epel'`.
* Use `yum_epel_repository` for individual repository declarations.
* Configure repository behavior with resource properties instead of node attributes.
* Wrapper cookbooks should move old role, environment, or recipe attribute overrides into explicit resource declarations.

## Common Migrations

### Default recipe

```ruby
# Before
include_recipe 'yum-epel'

# After
yum_epel 'default'
```

### Disable epel

```ruby
# Before
node.default['yum']['epel']['enabled'] = false
include_recipe 'yum-epel'

# After
yum_epel 'default' do
  disabled_repositories ['epel']
end
```

### Enable testing repositories

```ruby
# Before
node.default['yum']['epel-testing']['enabled'] = true
node.default['yum']['epel-testing']['managed'] = true
include_recipe 'yum-epel'

# After
yum_epel 'testing' do
  repositories %w(epel epel-testing)
  enabled_repositories %w(epel epel-testing)
end
```

### Internal mirror

```ruby
# Before
node.default['yum']['epel']['mirrorlist'] = nil
node.default['yum']['epel']['baseurl'] = 'https://internal.example.com/centos/9/os/x86_64'
node.default['yum']['epel']['sslverify'] = false
include_recipe 'yum-epel'

# After
yum_epel_repository 'epel' do
  mirrorlist nil
  baseurl 'https://internal.example.com/centos/9/os/x86_64'
  sslverify false
end
```

## Test Cookbook Examples

The integration test cookbook under `test/cookbooks/test/recipes/` shows the supported replacement patterns:

* `test::default` declares `yum_epel 'default'`.
* `test::all` declares `yum_epel 'all'` with all platform-supported repositories enabled.
