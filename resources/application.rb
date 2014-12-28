#
# Cookbook Name:: waxpoetic
# Resource:: application
#
# Describes attributes for the omakase_application LWRP.
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

actions :deploy

CFG_PATH = '/etc/profile.d/rails.sh'

attribute :directory,          kind_of: [String], name_attribute: true
attribute :user,               kind_of: [String], default: 'app'
attribute :repo,               kind_of: [String]
attribute :revision,           kind_of: [String]
attribute :keep_releases,      kind_of: [Fixnum]
attribute :rollback_on_error,  kind_of: [TrueClass, FalseClass], default: true
attribute :database_adapter,   kind_of: [Symbol], default: :postgresql
attribute :database_connection, kind_of: [Hash], default: {}
attribute :database_user,      kind_of: [String], default: 'app'
attribute :ruby_version,       kind_of: [String], default: '2.1.5'
attribute :rails_env,          kind_of: [String], default: 'development'
attribute :services,           kind_of: [Array],     default: ['puma']
attribute :fqdn,               kind_of: [String], default: node.fqdn
attribute :bundler_args,       kind_of: [String], default: [
  '--deployment',
  '--jobs=4',
  '--without development test'
].join("\s")

attribute :credentials,           kind_of: [Hash], default: {}
attribute :credentials_file_path, kind_of: [String], default: CFG_PATH
