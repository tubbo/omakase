attribute :user,          kind_of: [String],  default: 'app'
attribute :environment,   kind_of: [String],  default: 'development', name_attribute: true
attribute :ruby_version,  kind_of: [String],  default: 'ruby-2.1.5'
attribute :services,      kind_of: [Array],   default: ['puma']
attribute :bundler_args,       kind_of: [String], default: [
  '--deployment',
  '--jobs=4',
  '--without development test'
].join("\s")
attribute :credentials,           kind_of: [Hash], default: {}
attribute :credentials_file_path, kind_of: [String], default: '/etc/profile.d/rails.sh'
