module Persistable
    module ClassMethods
        def self.extended(base)
            base.class_variable_set(:@@all, [])
        end

        def all
            self.class_variable_get(:@@all)
        end

        def find_or_create_by_name(name)
            exists?(name) ? find_by_name(name) : new(name)
        end



    end

    module InstanceMethods
        def save
            self.class.all << self
            self
        end

    end
    

end
