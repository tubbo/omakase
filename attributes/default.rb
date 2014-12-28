#
# Cookbook Name:: omakase
# Attributes:: default
#
# These attributes are set up as an example only. They are mostly used
# as fixture data within Test Kitchen to stand up test instances of this
# cookbook. For more information on how to properly use this cookbook,
# see the README.
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

default['omakase']['repository'] = 'https://github.com/tubbo/breakbeat.git'
default['omakase']['user'] = 'breakbeat'
default['omakase']['version'] = 'master'
default['omakase']['keep_releases'] = 1
default['omakase']['rollback_on_error'] = false
default['omakase']['database_adapter'] = :postgresql
default['omakase']['master_database_password'] = SecureRandom.hex.to_s
default['omakase']['environment'] = 'development'
default['omakase']['services'] = %w(puma)
