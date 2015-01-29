attribute :repository,               kind_of: [String]
attribute :reference,           kind_of: [String], default: 'master'
attribute :keep_releases,      kind_of: [Fixnum], default: 5
attribute :rollback_on_error,  kind_of: [TrueClass, FalseClass], default: true
