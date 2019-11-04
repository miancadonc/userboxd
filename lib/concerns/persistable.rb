module Persistable
    module ClassMethods
        def self.extended(base)
            base.class_variable_set(:@@all, [])
        end

        def all
            self.class_variable_get(:@@all)
        end

    end

    module InstanceMethods
        def save
            self.class.all << self
            self
        end

    end
    

end
