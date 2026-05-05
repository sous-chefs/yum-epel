# yum_epel

Manages the platform's default set of EPEL repositories by declaring `yum_epel_repository` resources.

## Actions

| Action    | Description                                      |
|-----------|--------------------------------------------------|
| `:create` | Creates the selected repositories (default)      |
| `:remove` | Removes the selected repository configuration    |

## Properties

* `cleanup_stock_files` - Removes stock `epel-release` repo files before
  managing repositories. Defaults to `true`.
* `disabled_repositories` - Repository IDs to create disabled. Defaults to `[]`.
* `enabled_repositories` - Repository IDs to create enabled, or `:all`. Defaults
  to `:default`.
* `repositories` - Repository IDs to manage, or `:all`. Defaults to `:default`.
* `repository_options` - Per-repository `yum_repository` option overrides.
  Defaults to `{}`.

## Examples

### Default repositories

```ruby
yum_epel 'default'
```

### Enable all platform repositories

```ruby
yum_epel 'all' do
  repositories :all
  enabled_repositories :all
end
```

### Override one repository

```ruby
yum_epel 'internal' do
  repository_options(
    'epel' => {
      mirrorlist: nil,
      baseurl: 'https://internal.example.com/centos/9/os/x86_64',
      sslverify: false,
    }
  )
end
```
