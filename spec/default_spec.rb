require 'spec_helper'

describe 'yum-epel::default' do
  context 'yum-epel::default uses default attributes' do
    let(:chef_run) { ChefSpec::Runner.new(:step_into => ['yum_repository']).converge(described_recipe) }

    %w{
      epel
      epel-debuginfo
      epel-source
      epel-testing
      epel-testing-debuginfo
      epel-testing-source
      }.each do |repo|
      it "creates yum_repository[#{repo}]" do
        expect(chef_run).to create_yum_repository(repo)
      end

      it "steps into yum_repository and creates template[/etc/yum.repos.d/#{repo}.repo]" do
        expect(chef_run).to render_file("/etc/yum.repos.d/#{repo}.repo")
      end
    end

  end
end
