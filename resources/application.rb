actions :deploy

CFG_PATH = '/etc/profile.d/rails.sh'

attribute :directory,          kind_of: [String], name_attribute: true
attribute :user,               kind_of: [String], default: 'app'
attribute :repo,               kind_of: [String]
attribute :revision,           kind_of: [String]
attribute :keep_releases,      kind_of: [Fixnum]
attribute :rollback_on_error,  kind_of: [TrueClass, FalseClass], default: true
attribute :services,           kind_of: [Array],     default: ['puma']
attribute :database_adapter,   kind_of: [Symbol], default: :postgresql
attribute :ruby_version,       kind_of: [String], default: '2.1.5'
attribute :rails_env,          kind_of: [String], default: 'development'
attribute :fqdn,               kind_of: [String], default: node.fqdn
attribute :bundler_args,       kind_of: [String], default: [
  '--deployment',
  '--jobs=4',
  '--without development test'
].join("\s")

attribute :credentials,           kind_of: [Hash], default: {}
attribute :credentials_file_path, kind_of: [String], default: CFG_PATH
