
class Film
    
    attr_accessor :name
    extend Persistable::ClassMethods, Findable
    include Persistable::InstanceMethods, Nameable
end
