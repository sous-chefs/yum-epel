# frozen_string_literal: true

os_release = os.name == 'amazon' ? 9 : os.release.to_i
basearch = command('rpm --eval %{_arch}').stdout.strip
stream = file('/etc/os-release').content.match?('Stream')
epel_next_expected = stream && os_release < 10
testing_prefix = os_release >= 10 ? 'epel-z-testing' : 'testing-epel'
testing_debug_repo = os_release >= 10 ? "epel-z-testing-debug-#{os_release}" : "testing-debug-epel#{os_release}"
testing_source_repo = os_release >= 10 ? "epel-z-testing-source-#{os_release}" : "testing-source-epel#{os_release}"

describe yum.repo 'epel' do
  it { should exist }
  it { should be_enabled }
  its('mirrors') { should cmp "https://mirrors.fedoraproject.org/mirrorlist?repo=epel-#{os_release}&arch=#{basearch}" }
end

describe yum.repo 'epel-debuginfo' do
  it { should exist }
  it { should be_enabled }
  its('mirrors') { should cmp "https://mirrors.fedoraproject.org/mirrorlist?repo=epel-debug-#{os_release}&arch=#{basearch}" }
end

describe yum.repo 'epel-source' do
  it { should exist }
  it { should be_enabled }
  its('mirrors') { should cmp "https://mirrors.fedoraproject.org/mirrorlist?repo=epel-source-#{os_release}&arch=#{basearch}" }
end

describe yum.repo 'epel-testing' do
  it { should exist }
  it { should be_enabled }
  its('mirrors') { should cmp "https://mirrors.fedoraproject.org/mirrorlist?repo=#{testing_prefix}-#{os_release}&arch=#{basearch}" }
end

describe yum.repo 'epel-testing-debuginfo' do
  it { should exist }
  it { should be_enabled }
  its('mirrors') { should cmp "https://mirrors.fedoraproject.org/mirrorlist?repo=#{testing_debug_repo}&arch=#{basearch}" }
end

describe yum.repo 'epel-testing-source' do
  it { should exist }
  it { should be_enabled }
  its('mirrors') { should cmp "https://mirrors.fedoraproject.org/mirrorlist?repo=#{testing_source_repo}&arch=#{basearch}" }
end

if epel_next_expected
  describe yum.repo 'epel-next' do
    it { should exist }
    it { should be_enabled }
    its('mirrors') { should cmp "https://mirrors.fedoraproject.org/mirrorlist?repo=epel-next-#{os_release}&arch=#{basearch}" }
  end

  describe yum.repo 'epel-next-debuginfo' do
    it { should exist }
    it { should be_enabled }
    its('mirrors') { should cmp "https://mirrors.fedoraproject.org/mirrorlist?repo=epel-next-debug-#{os_release}&arch=#{basearch}" }
  end

  describe yum.repo 'epel-next-source' do
    it { should exist }
    it { should be_enabled }
    its('mirrors') { should cmp "https://mirrors.fedoraproject.org/mirrorlist?repo=epel-next-source-#{os_release}&arch=#{basearch}" }
  end

  describe yum.repo 'epel-next-testing' do
    it { should exist }
    it { should be_enabled }
    its('mirrors') { should cmp "https://mirrors.fedoraproject.org/mirrorlist?repo=epel-testing-next-#{os_release}&arch=#{basearch}" }
  end

  describe yum.repo 'epel-next-testing-debuginfo' do
    it { should exist }
    it { should be_enabled }
    its('mirrors') { should cmp "https://mirrors.fedoraproject.org/mirrorlist?repo=epel-testing-next-debug-#{os_release}&arch=#{basearch}" }
  end

  describe yum.repo 'epel-next-testing-source' do
    it { should exist }
    it { should be_enabled }
    its('mirrors') { should cmp "https://mirrors.fedoraproject.org/mirrorlist?repo=testing-source-epel#{os_release}&arch=#{basearch}" }
  end
end
