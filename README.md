# omakase cookbook

A cookbook for deploying service-oriented applications with Ruby on
Rails. Omakase assumes very little about what tools you use(d) to build
your application, but is opinionated about the structure of your
environment in order to maintain clean and elegant deployments. It also
assumes that you're using a relational database of some kind, as it's
configured by default to run migrations. Omakase makes use of several
existing cookbooks like [chruby][ch] and [nginx][ng] for dependencies as
well as the [database][db] cookbook and [deploy][dp] resource to make
transitioning from your existing 200-line `deploy` call into using the
cookbook much easier.

Omakase takes much of its cues from the [12-factor app][12f] deployment
and maintenence techniques. It is the project's goal to make deploying
Rails apps safer, easier, and faster using Chef. Much of Omakase's
initial code was extracted from [Wax Poetic][wp]'s application cookbook,
which is now wrapping Omakase instead of providing a separate
implementation.

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

```ruby
omakase_application '/srv/my_app' do
  user 'app'

  repo 'git@github.com:me/myapp.git'
  revision node['app']['version']
  keep_releases 1
  rollback_on_error false

  rails_env node['app']['environment']
  ruby_version node['app']['ruby']
  services %w(puma sidekiq)

  database_adapter :postgresql
  database_connection password: node['app']['master_password']
  database_user 'app'
end
```

This LWRP will install the following dependencies:

- nginx
- ruby-install
- chruby
- the bundler gem
- whatever Ruby version you configured

After doing this, it will configure your database. It will conditionally
load an LWRP based on the `database_adapter` attribute, and apply
default database connection parameters in order to add the app's
database user and grant it DB creation abilities. This will allow the
`deploy` resource to perform database commands.

Once the database is configured, it's time to run the `deploy` resource
for your application. This resource is configured to also run `bundle
install`, set up the database, and precompile assets. It can also
optionally be configured to clear any caches using `rake cache:clear`.

What it will **not** do is set up your database server. Any databases
such as PostgreSQL or Redis must be running _before_ this LWRP is invoked.
We use the [database][db] cookbook to run commands on the DBMS, so be
sure your `database_adapter` setting is supported within that cookbook.

## Development

Please include tests and submit all contributions in a pull request.
Tests must pass within a `kitchen test` (isolated convergence of every
suite) in order to be considered for acceptance into 'master'.

### Roadmap

Eventually, it would be cool if the resource looked like this:

```ruby
omakase_application '/srv/my_app' do
  code do
    repository 'git@github.com:me/myapp.git'
    reference 'master'
    releases 1
    rollback_on_error true
  end

  rails do
    user 'app'
    environment 'development'
    ruby_version 'ruby-2.1.5'
    services %w(puma sidekiq)
  end

  database do
    adapter :postgresql
    user 'app'
    master_password 'master-password'
  end
end
```

And, for quick defaults:

```ruby
omakase_application '/srv/my_app' do
  code      'git@github.com:me/myapp.git'
  rails     'development'
  database  :postgresql
end
```


## License and Authors

**Author:** Tom Scott (<tubbo@psychedeli.ca>)

**License:** MIT

[db]: https://supermarket.chef.io/cookbooks/database
[ch]: https://supermarket.chef.io/cookbooks/chruby
[ng]: https://supermarket.chef.io/cookbooks/nginx
[dp]: https://docs.getchef.com/resource_deploy.html
[12f]: http://12factor.net/
[wp]: https://github.com/waxpoetic
