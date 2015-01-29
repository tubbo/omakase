attribute :adapter,   kind_of: [Symbol], default: :postgresql
attribute :user,      kind_of: [String], default: 'app'
attribute :master_user,      kind_of: [String], default: 'postgres'
attribute :master_password,      kind_of: [String, NilClass], default: nil
