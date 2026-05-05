# frozen_string_literal: true

provides :yum_epel_repository
unified_mode true

property :repo_name, String, name_property: true
property :baseurl, [String, NilClass]
property :description, [String, NilClass]
property :enabled, [true, false]
property :gpgcheck, [true, false]
property :gpgkey, [String, Array, NilClass]
property :make_cache, [true, false]
property :mirrorlist, [String, NilClass]
property :options, Hash, default: {}
property :repositoryid, [String, NilClass]
property :sslverify, [true, false, NilClass]

default_action :create

action_class do
  include YumEpel::Cookbook::Helpers

  def resolved_property(defaults, property)
    return new_resource.send(property) if new_resource.property_is_set?(property)

    defaults[property]
  end

  def resolved_repository_config
    defaults = epel_repository_defaults(new_resource.repo_name)

    {
      baseurl: resolved_property(defaults, :baseurl),
      description: resolved_property(defaults, :description),
      enabled: resolved_property(defaults, :enabled),
      gpgcheck: resolved_property(defaults, :gpgcheck),
      gpgkey: resolved_property(defaults, :gpgkey),
      make_cache: resolved_property(defaults, :make_cache),
      mirrorlist: resolved_property(defaults, :mirrorlist),
      repositoryid: resolved_property(defaults, :repositoryid),
      sslverify: resolved_property(defaults, :sslverify),
    }.merge(new_resource.options.transform_keys(&:to_sym))
  end
end

action :create do
  repo_config = resolved_repository_config

  yum_repository new_resource.repo_name do
    repo_config.each do |config, value|
      send(config, value) unless value.nil?
    end
    action :create
  end
end

action :remove do
  yum_repository new_resource.repo_name do
    action :remove
  end
end
