load 'lib/concerns/findable.rb'
load 'lib/concerns/persistable.rb'
load 'lib/concerns/nameable.rb'
class User
    attr_accessor :name
    extend Persistable::ClassMethods, Findable
    include Persistable::InstanceMethods, Nameable
end
