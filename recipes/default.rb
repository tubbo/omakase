#
# Cookbook Name:: omakase
# Recipe:: default
#
# Installs an application configured with attributes. This is _not_ the
# recommended way to use this cookbook. For more information, see the
# README.
#
# Copyright (C) 2014 Tom Scott
# License: MIT
#

omakase_application node['omakase']['dir'] do
  user node['omakase']['user']
  repo node['omakase']['repository']
  revision node['omakase']['version']
  keep_releases node['omakase']['keep_releases']
  rollback_on_error node['omakase']['rollback_on_error']
  database_adapter node['omakase']['database_adapter']
  database_connection password: node['omakase']['master_database_password']
  database_user node['omakase']['user']
  rails_env node['omakase']['environment']
  services node['omakase']['services']
end
