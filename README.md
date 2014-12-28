# omakase cookbook

A Chef cookbook for deploying a service-oriented Rails application.
Omakase assumes that your Rails app is comprised of services, you use
Upstart as your init engine, you're serving static files with Nginx, and
you're running some flavor of Linux.

## Supported Platforms

- Ubuntu 14

## Installation

Add the following line to your cookbook's `metadata.rb`:

```ruby
depends 'omakase'
```

Then, run:

```bash
$ berks install
```

## Usage

Wrap this cookbook with your own app cookbook and use the following
LWRP to deploy the app:

### omakase_application

Use this resource in your recipe to deploy a Rails app.

```ruby
omakase_application '/srv/waxpoetic' do
  repo "https://#{data_bag_item(:credentials, :github_token)}@github.com/waxpoetic/waxpoeticrecords.com.git"
  revision node['myapp']['version']
  keep_releases 2
  rollback_on_error false
  database_adapter :postgresql
  database_connection :password => 'master-password'
  database_user 'waxpoetic'
  services %w(puma sidekiq)
end
```

## License and Authors

*Author:* Tom Scott (<tubbo@psychedeli.ca>)

*License:* MIT
