os_release = os.name == 'amazon' ? '7' : os.release.to_i

describe yum.repo 'epel' do
  it { should exist }
  it { should be_enabled }
  its('mirrors') { should cmp "https://mirrors.fedoraproject.org/mirrorlist?repo=epel-#{os_release}&arch=x86_64" }
end
