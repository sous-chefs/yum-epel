# frozen_string_literal: true

module YumEpel
  module Cookbook
    module Helpers
      STANDARD_REPOSITORIES = %w(
        epel
        epel-debuginfo
        epel-source
        epel-testing
        epel-testing-debuginfo
        epel-testing-source
      ).freeze unless const_defined?(:STANDARD_REPOSITORIES)

      NEXT_REPOSITORIES = %w(
        epel-next
        epel-next-debuginfo
        epel-next-source
        epel-next-testing
        epel-next-testing-debuginfo
        epel-next-testing-source
      ).freeze unless const_defined?(:NEXT_REPOSITORIES)

      REPOSITORIES = (STANDARD_REPOSITORIES + NEXT_REPOSITORIES).freeze unless const_defined?(:REPOSITORIES)

      def default_epel_repositories
        repos = %w(epel)
        repos << 'epel-next' if epel_next_available?
        repos
      end

      def all_epel_repositories
        repos = STANDARD_REPOSITORIES.dup
        repos.concat(NEXT_REPOSITORIES) if epel_next_available?
        repos
      end

      def epel_next_available?
        centos_stream? && yum_epel_release < 10
      end

      def yum_epel_release
        if platform?('amazon')
          case node['platform_version'].to_i
          when 2023
            9
          when 2
            7
          else
            node['platform_version'].to_i
          end
        else
          node['platform_version'].to_i
        end
      end

      def default_epel_enabled?(repo_name)
        %w(epel epel-next).include?(repo_name)
      end

      def epel_repository_defaults(repo_name)
        validate_epel_repository!(repo_name)

        config = {
          repositoryid: repo_name,
          gpgcheck: true,
          enabled: default_epel_enabled?(repo_name),
          make_cache: true,
        }

        if repo_name == 'epel' && armv7?
          return config.merge(
            baseurl: 'https://armv7.dev.centos.org/repodir/epel-pass-1/',
            gpgcheck: false
          )
        end

        if repo_name == 'epel' && s390x?
          return config.merge(
            baseurl: 'https://kojipkgs.fedoraproject.org/rhel/rc/7/Server/s390x/os/',
            gpgkey: 'https://kojipkgs.fedoraproject.org/rhel/rc/7/Server/s390x/os/RPM-GPG-KEY-redhat-release'
          )
        end

        config.merge(
          description: epel_repository_description(repo_name),
          mirrorlist: "https://mirrors.fedoraproject.org/mirrorlist?repo=#{epel_mirror_repo(repo_name)}&arch=$basearch",
          gpgkey: "https://download.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-#{yum_epel_release}"
        )
      end

      def stock_epel_repo_files
        {
          '/etc/yum.repos.d/epel.repo' => %w(epel epel-debuginfo epel-source),
          '/etc/yum.repos.d/epel-testing.repo' => %w(epel-testing epel-testing-debuginfo epel-testing-source),
          '/etc/yum.repos.d/epel-next.repo' => %w(epel-next epel-next-debuginfo epel-next-source),
          '/etc/yum.repos.d/epel-next-testing.repo' => %w(epel-next-testing epel-next-testing-debuginfo epel-next-testing-source),
        }
      end

      private

      def validate_epel_repository!(repo_name)
        return if REPOSITORIES.include?(repo_name)

        raise ArgumentError, "Unsupported EPEL repository '#{repo_name}'. Supported repositories: #{REPOSITORIES.join(', ')}"
      end

      def centos_stream?
        return centos_stream_platform? if respond_to?(:centos_stream_platform?)
        return true if platform?('centos_stream')
        return true if node.dig('os_release', 'name').to_s.include?('Stream')

        false
      end

      def armv7?
        %w(armv7l armv7hl).include?(node.dig('kernel', 'machine'))
      end

      def s390x?
        node.dig('kernel', 'machine') == 's390x'
      end

      def epel_mirror_repo(repo_name)
        case repo_name
        when 'epel'
          "epel-#{yum_epel_release}"
        when 'epel-debuginfo'
          "epel-debug-#{yum_epel_release}"
        when 'epel-source'
          "epel-source-#{yum_epel_release}"
        when 'epel-testing'
          yum_epel_release >= 10 ? "epel-z-testing-#{yum_epel_release}" : "testing-epel#{yum_epel_release}"
        when 'epel-testing-debuginfo'
          yum_epel_release >= 10 ? "epel-z-testing-debug-#{yum_epel_release}" : "testing-debug-epel#{yum_epel_release}"
        when 'epel-testing-source'
          yum_epel_release >= 10 ? "epel-z-testing-source-#{yum_epel_release}" : "testing-source-epel#{yum_epel_release}"
        when 'epel-next-testing-source'
          "testing-source-epel#{yum_epel_release}"
        when 'epel-next'
          "epel-next-#{yum_epel_release}"
        when 'epel-next-debuginfo'
          "epel-next-debug-#{yum_epel_release}"
        when 'epel-next-source'
          "epel-next-source-#{yum_epel_release}"
        when 'epel-next-testing'
          "epel-testing-next-#{yum_epel_release}"
        when 'epel-next-testing-debuginfo'
          "epel-testing-next-debug-#{yum_epel_release}"
        end
      end

      def epel_repository_description(repo_name)
        case repo_name
        when 'epel'
          "Extra Packages for #{yum_epel_release} - $basearch"
        when 'epel-debuginfo'
          "Extra Packages for #{yum_epel_release} - $basearch - Debug"
        when 'epel-source'
          "Extra Packages for #{yum_epel_release} - $basearch - Source"
        when 'epel-testing'
          "Extra Packages for #{yum_epel_release} - $basearch - Testing "
        when 'epel-testing-debuginfo'
          "Extra Packages for #{yum_epel_release} - $basearch - Testing Debug"
        when 'epel-testing-source'
          "Extra Packages for #{yum_epel_release} - $basearch - Testing Source"
        when 'epel-next'
          'Extra Packages for $releasever - Next - $basearch'
        when 'epel-next-debuginfo'
          "Extra Packages for #{yum_epel_release} - $basearch - Next - Debug"
        when 'epel-next-source'
          "Extra Packages for #{yum_epel_release} $basearch - Next -Source"
        when 'epel-next-testing'
          "Extra Packages for #{yum_epel_release} - $basearch - Next - Testing"
        when 'epel-next-testing-debuginfo'
          "Extra Packages for #{yum_epel_release} - $basearch - Next - Testing Debug"
        when 'epel-next-testing-source'
          "Extra Packages for #{yum_epel_release} - $basearch - Next - Testing Source"
        end
      end
    end
  end
end
