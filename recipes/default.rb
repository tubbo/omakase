#
# Cookbook Name:: omakase
# Recipe:: default
#
# Installs an application configured with attributes. This is _not_ the
# recommended way to use this cookbook. For more information, see the
# README.
#
# Copyright (C) 2014 Tom Scott
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

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
  ruby_version node['omakase']['ruby_version']
  services node['omakase']['services']
end
