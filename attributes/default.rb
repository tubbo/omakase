
# These attributes are set up as an example only. They are mostly used
# as fixture data within Test Kitchen to stand up test instances of this
# cookbook.

default['omakase']['repository'] = 'https://github.com/tubbo/breakbeat.git'
default['omakase']['user'] = 'breakbeat'
default['omakase']['version'] = 'master'
default['omakase']['keep_releases'] = 1
default['omakase']['rollback_on_error'] = false
default['omakase']['database_adapter'] = :postgresql
default['omakase']['master_database_password'] = SecureRandom.hex.to_s
default['omakase']['environment'] = 'development'
default['omakase']['services'] = %w(puma)
