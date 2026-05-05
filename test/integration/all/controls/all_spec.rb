# frozen_string_literal: true

os_release = os.name == 'amazon' ? 9 : os.release.to_i
basearch = '$basearch'
stream = file('/etc/os-release').content.match?('Stream')
epel_next_expected = stream && os_release < 10
testing_repo = os_release >= 10 ? "epel-z-testing-#{os_release}" : "testing-epel#{os_release}"
testing_debug_repo = os_release >= 10 ? "epel-z-testing-debug-#{os_release}" : "testing-debug-epel#{os_release}"
testing_source_repo = os_release >= 10 ? "epel-z-testing-source-#{os_release}" : "testing-source-epel#{os_release}"

def repo_file(repo)
  file("/etc/yum.repos.d/#{repo}.repo")
end

def describe_repo(repo, mirrorlist)
  describe repo_file(repo) do
    it { should exist }
    its('content') { should include "[#{repo}]" }
    its('content') { should include 'enabled=1' }
    its('content') { should include "mirrorlist=#{mirrorlist}" }
  end
end

describe_repo('epel', "https://mirrors.fedoraproject.org/mirrorlist?repo=epel-#{os_release}&arch=#{basearch}")

describe_repo('epel-debuginfo', "https://mirrors.fedoraproject.org/mirrorlist?repo=epel-debug-#{os_release}&arch=#{basearch}")

describe_repo('epel-source', "https://mirrors.fedoraproject.org/mirrorlist?repo=epel-source-#{os_release}&arch=#{basearch}")

describe_repo('epel-testing', "https://mirrors.fedoraproject.org/mirrorlist?repo=#{testing_repo}&arch=#{basearch}")

describe_repo('epel-testing-debuginfo', "https://mirrors.fedoraproject.org/mirrorlist?repo=#{testing_debug_repo}&arch=#{basearch}")

describe_repo('epel-testing-source', "https://mirrors.fedoraproject.org/mirrorlist?repo=#{testing_source_repo}&arch=#{basearch}")

if epel_next_expected
  describe_repo('epel-next', "https://mirrors.fedoraproject.org/mirrorlist?repo=epel-next-#{os_release}&arch=#{basearch}")

  describe_repo('epel-next-debuginfo', "https://mirrors.fedoraproject.org/mirrorlist?repo=epel-next-debug-#{os_release}&arch=#{basearch}")

  describe_repo('epel-next-source', "https://mirrors.fedoraproject.org/mirrorlist?repo=epel-next-source-#{os_release}&arch=#{basearch}")

  describe_repo('epel-next-testing', "https://mirrors.fedoraproject.org/mirrorlist?repo=epel-testing-next-#{os_release}&arch=#{basearch}")

  describe_repo('epel-next-testing-debuginfo', "https://mirrors.fedoraproject.org/mirrorlist?repo=epel-testing-next-debug-#{os_release}&arch=#{basearch}")

  describe_repo('epel-next-testing-source', "https://mirrors.fedoraproject.org/mirrorlist?repo=testing-source-epel#{os_release}&arch=#{basearch}")
end
