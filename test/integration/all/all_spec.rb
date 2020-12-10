os_release = os.name == 'amazon' ? '7' : os.release.to_i

describe yum.repo 'epel' do
  it { should exist }
  it { should be_enabled }
  its('mirrors') { should cmp "https://mirrors.fedoraproject.org/mirrorlist?repo=epel-#{os_release}&arch=x86_64" }
end

describe yum.repo 'epel-debuginfo' do
  it { should exist }
  it { should be_enabled }
  its('mirrors') { should cmp "https://mirrors.fedoraproject.org/mirrorlist?repo=epel-debug-#{os_release}&arch=x86_64" }
end

describe yum.repo 'epel-source' do
  it { should exist }
  it { should be_enabled }
  its('mirrors') { should cmp "https://mirrors.fedoraproject.org/mirrorlist?repo=epel-source-#{os_release}&arch=x86_64" }
end

describe yum.repo 'epel-testing' do
  it { should exist }
  it { should be_enabled }
  its('mirrors') { should cmp "https://mirrors.fedoraproject.org/mirrorlist?repo=testing-epel#{os_release}&arch=x86_64" }
end

describe yum.repo 'epel-testing-debuginfo' do
  it { should exist }
  it { should be_enabled }
  its('mirrors') { should cmp "https://mirrors.fedoraproject.org/mirrorlist?repo=testing-debug-epel#{os_release}&arch=x86_64" }
end

describe yum.repo 'epel-testing-source' do
  it { should exist }
  it { should be_enabled }
  its('mirrors') { should cmp "https://mirrors.fedoraproject.org/mirrorlist?repo=testing-source-epel#{os_release}&arch=x86_64" }
end
