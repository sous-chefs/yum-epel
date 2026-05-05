# frozen_string_literal: true

os_release = os.name == 'amazon' ? 9 : os.release.to_i
basearch = command('rpm --eval %{_arch}').stdout.strip
stream = file('/etc/os-release').content.match?('Stream')
epel_next_expected = stream && os_release < 10

describe yum.repo 'epel' do
  it { should exist }
  it { should be_enabled }
  its('mirrors') { should cmp "https://mirrors.fedoraproject.org/mirrorlist?repo=epel-#{os_release}&arch=#{basearch}" }
end

describe yum.repo 'epel-next' do
  it { should exist }
  it { should be_enabled }
end if epel_next_expected

optional_repositories = %w(
  epel-debuginfo
  epel-source
  epel-testing
  epel-testing-debuginfo
  epel-testing-source
)

optional_repositories.push(
  'epel-next-debuginfo',
  'epel-next-source',
  'epel-next-testing',
  'epel-next-testing-debuginfo',
  'epel-next-testing-source'
) if epel_next_expected

optional_repositories.each do |repo|
  describe yum.repo repo do
    it { should_not exist }
    it { should_not be_enabled }
  end
end
