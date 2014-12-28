name             'omakase'
maintainer       'Tom Scott'
maintainer_email 'tubbo@psychedeli.ca'
license          'MIT'
description      'Deploys a services-oriented Rails app'
long_description 'Deploys a Rails app that uses services as its backend.'
version          '0.0.2'

depends 'nginx'
depends 'ruby-install'
depends 'chruby'
depends 'database'
depends 'nodejs'

provides 'omakase_application'

supports 'ubuntu', '14.10'
