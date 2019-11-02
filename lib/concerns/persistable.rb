module Persistable
    # module ClassMethods
    #     def self.extended(base)
    #         puts "#{base} has been extended by #{self}"
    #         base.class_variable_set(@@all, [])
    #     end

    #     def all
    #         @@all
    #     end


    # end

    module InstanceMethods
        def save
            #self.class.all << self
            puts "calling save"
        end

        def create
            #self.new.save
            puts "calling create"
        end


    end
    

end
