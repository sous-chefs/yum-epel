# yum_epel_repository

Manages one EPEL repository using Chef Infra's `yum_repository` resource.

## Actions

| Action    | Description                                   |
|-----------|-----------------------------------------------|
| `:create` | Creates the repository configuration (default) |
| `:remove` | Removes the repository configuration          |

## Properties

| Property       | Type                | Default          | Description                                      |
|----------------|---------------------|------------------|--------------------------------------------------|
| `repo_name`    | String              | name property    | EPEL repository ID                               |
| `baseurl`      | String, nil         | helper default   | Base URL override                                |
| `description`  | String, nil         | helper default   | Repository description                           |
| `enabled`      | true, false         | helper default   | Whether the repository is enabled                |
| `gpgcheck`     | true, false         | helper default   | Whether package GPG checking is enabled          |
| `gpgkey`       | String, Array, nil  | helper default   | Repository GPG key URL                           |
| `make_cache`   | true, false         | helper default   | Whether `yum_repository` should build cache      |
| `mirrorlist`   | String, nil         | helper default   | Fedora mirrorlist URL                            |
| `options`      | Hash                | `{}`             | Additional `yum_repository` properties           |
| `repositoryid` | String, nil         | `repo_name`      | Repository ID passed to `yum_repository`         |
| `sslverify`    | true, false, nil    | helper default   | SSL verification setting                         |

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
