#
# Cookbook Name:: waxpoetic
# Provider:: application
#
# Defines all convergence actions when this omakase_application is
# deployed.
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

action :deploy do
  bundle = "chruby-exec #{new_resource.ruby_version} -- ./bin/bundle"
  rake = "#{bundle} exec rake"

  include_recipe 'nginx'
  include_recipe 'ruby-install'
  include_recipe 'chruby'
  include_recipe "database::#{new_resource.database_adapter}"
  include_recipe "#{new_resource.database_adapter}::server"
  include_recipe 'nodejs'

  ruby_install_ruby new_resource.ruby_version do
    action :install
  end

  gem_package 'bundler' do
    gem_binary "/opt/rubies/#{new_resource.ruby_version}/bin/gem"
    action :install
  end

  new_resource.services.each do |service_name|
    template "/etc/init/#{service_name}.conf" do
      source 'service.conf.erb'
      owner 'root'
      group 'root'
      mode '0775'
      variables \
        name: service_name,
        user: new_resource.user,
        version: new_resource.revision,
        directory: new_resource.directory,
        ruby: new_resource.ruby_version
    end

    service service_name do
      provider Chef::Provider::Service::Upstart
      action :nothing
    end
  end

  directory new_resource.directory do
    owner new_resource.user
    group new_resource.user
    mode '0755'
  end

  merged_credentials = new_resource.credentials.merge(
    'rails_env' => new_resource.rails_env
  )

  template new_resource.credentials_file_path do
    source 'env.sh.erb'
    variables credentials: merged_credentials
  end

  adapter = new_resource.database_adapter
  dbc = case adapter
        when :mysql
          {
            host: '127.0.0.1',
            port: 3306,
            username: 'root',
            password: 'mysql'
          }
        when :postgresql
          {
            host: 'localhost',
            port: 5432,
            username: 'postgres',
            password: nil
          }
        else
          {
            host: 'localhost',
            port: 1337,
            username: 'root',
            password: nil
          }
        end

  send("#{adapter}_database_user", new_resource.database_user) do
    connection dbc.merge(new_resource.database_connection)
    password CREDS['database_password']
  end

  send("#{adapter}_database", 'template1') do
    connection dbc.merge(new_resource.database_connection)
    sql %(ALTER USER #{new_resource.database_user} CREATEDB;)
    action :query
  end

  deploy new_resource.directory do
    user new_resource.user
    group new_resource.user

    repo new_resource.repository
    revision new_resource.revision
    keep_releases new_resource.keep_releases
    rollback_on_error new_resource.rollback_on_error

    before_migrate do
      shared_path = "#{new_resource.directory}/shared"
      path_arg = "--path=#{shared_path}/bundle"

      directory "#{shared_path}/pids" do
        user new_resource.user
        group new_resource.user
      end

      directory "#{shared_path}/assets" do
        user new_resource.user
        group new_resource.user
      end

      execute 'install bundled dependencies' do
        cwd release_path
        user new_resource.user
        group new_resource.user
        command "#{bundle} install #{new_resource.bundler_args} #{path_arg}"
      end
    end
    symlink_before_migrate 'bundle' => 'vendor/bundle'

    # migrate the database
    migrate true
    migration_command "#{rake} db:setup RAILS_ENV=#{new_resource.rails_env}"
    create_dirs_before_symlink %w(tmp)

    # symlink pids for services
    purge_before_symlink []
    symlinks 'pids' => 'tmp/pids', 'assets' => 'public/assets'

    # compile assets and generate the secret key before restarting
    before_restart do
      execute 'precompile assets' do
        cwd "#{new_resource.directory}/current"
        user new_resource.user
        group new_resource.user
        command "#{rake} assets:precompile RAILS_ENV=#{new_resource.rails_env}"
      end
    end

    new_resource.services.each do |service_name|
      notifies :restart, "service[#{service_name}]"
    end
  end

  template '/etc/nginx/sites-available/waxpoetic' do
    source 'site.conf.erb'
    variables \
      directory: new_resource.directory,
      environment: new_resource.rails_env,
      domain: new_resource.fqdn,
      protect_access: false,
      secure: false
  end

  nginx_site 'default' do
    action :disable
  end

  file '/etc/nginx/sites-available/default' do
    action :delete
  end

  nginx_site 'waxpoetic' do
    action :enable
  end

  service 'nginx' do
    action :restart
  end
end
