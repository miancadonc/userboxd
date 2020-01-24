class User
    attr_accessor :name, :opinions
    extend Persistable::ClassMethods, Findable
    include Persistable::InstanceMethods

    def initialize(name)
        @name = name
        @opinions = []
        self.save
    end

    def add_opinion(opinion)
        self.opinions << opinion
    end


end
