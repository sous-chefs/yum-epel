module YumEpel
  module Cookbook
    module Helpers
      def centos_8_repos
        if yum_epel_centos_stream?
          %w(
            epel-modular
            epel-modular-debuginfo
            epel-modular-source
            epel-next
            epel-next-debuginfo
            epel-next-source
            epel-next-testing
            epel-next-testing-debuginfo
            epel-next-testing-source
            epel-playground
            epel-playground-debuginfo
            epel-playground-source
            epel-testing-modular
            epel-testing-modular-debuginfo
            epel-testing-modular-source
          )
        else
          %w(
            epel
            epel-debuginfo
            epel-modular
            epel-modular-debuginfo
            epel-modular-source
            epel-playground
            epel-playground-debuginfo
            epel-playground-source
            epel-source
            epel-testing
            epel-testing-debuginfo
            epel-testing-modular
            epel-testing-modular-debuginfo
            epel-testing-modular-source
            epel-testing-source
          )
        end
      end

      private

      def yum_epel_centos_stream?
        respond_to?(:centos_stream_platform?) && centos_stream_platform?
      end
    end
  end
end
# Needed to used in attributes/
Chef::Node.include ::YumEpel::Cookbook::Helpers
