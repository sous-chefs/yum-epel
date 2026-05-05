# yum_epel

Manages the platform's default set of EPEL repositories by declaring `yum_epel_repository` resources.

## Actions

| Action    | Description                                      |
|-----------|--------------------------------------------------|
| `:create` | Creates the selected repositories (default)      |
| `:remove` | Removes the selected repository configuration    |

## Properties

| Property                | Type           | Default     | Description                                      |
|-------------------------|----------------|-------------|--------------------------------------------------|
| `cleanup_stock_files`   | true, false    | `true`      | Removes stock `epel-release` repo files before managing repositories |
| `disabled_repositories` | Array          | `[]`        | Repository IDs to create disabled                |
| `enabled_repositories`  | Array, Symbol  | `:default`  | Repository IDs to create enabled, or `:all`      |
| `repositories`          | Array, Symbol  | `:default`  | Repository IDs to manage, or `:all`              |
| `repository_options`    | Hash           | `{}`        | Per-repository `yum_repository` option overrides |

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
