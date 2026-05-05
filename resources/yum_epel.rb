# frozen_string_literal: true

provides :yum_epel
unified_mode true

property :cleanup_stock_files, [true, false], default: true
property :disabled_repositories, Array, default: []
property :enabled_repositories, [Array, Symbol], default: :default
property :repositories, [Array, Symbol], default: :default
property :repository_options, Hash, default: {}

default_action :create

action_class do
  include YumEpel::Cookbook::Helpers

  def requested_repositories
    expand_repository_selection(new_resource.repositories)
  end

  def requested_enabled_repositories
    expand_repository_selection(new_resource.enabled_repositories)
  end

  def repository_enabled?(repo_name)
    requested_enabled_repositories.include?(repo_name) && !new_resource.disabled_repositories.include?(repo_name)
  end

  def expand_repository_selection(selection)
    case selection
    when :default
      default_epel_repositories
    when :all
      all_epel_repositories
    else
      selection
    end
  end
end

action :create do
  stock_epel_repo_files.each do |repo_file, repo_names|
    file repo_file do
      action :delete
      only_if { new_resource.cleanup_stock_files && (requested_repositories & repo_names).empty? }
    end
  end

  requested_repositories.each do |repo_name|
    yum_epel_repository repo_name do
      enabled repository_enabled?(repo_name)
      options new_resource.repository_options.fetch(repo_name, {})
      action :create
    end
  end
end

action :remove do
  requested_repositories.each do |repo_name|
    yum_epel_repository repo_name do
      action :remove
    end
  end
end
