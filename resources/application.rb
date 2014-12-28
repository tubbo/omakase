actions :deploy

attribute :directory, [String], name_attribute: true
attribute :repo, [String]
attribute :revision, [String]
attribute :keep_releases, [Fixnum]
attribute :rollback_on_error, [TrueClass, FalseClass], default: true
attribute :services, [Array], default: ['puma']
attribute :database_adapter, [Symbol], default: :postgresql
attribute :ruby_version, [String], default: '2.1.5'
attribute :rails_env, [String], default: 'development'
attribute :fqdn, [String], default: node.fqdn
attribute :bundler_args, [String], default: [
  '--deployment',
  '--jobs=4',
  '--without development test'
].join("\s")

attribute :credentials, [Hash], default: {}
attribute :credentials_file_path, [String], default: '/etc/profile.d/rails.sh'
