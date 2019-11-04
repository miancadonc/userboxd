load 'lib/concerns/findable.rb'
load 'lib/concerns/persistable.rb'
load 'lib/concerns/nameable.rb'
class User
    attr_accessor :name, :opinions
    extend Persistable::ClassMethods, Findable
    include Persistable::InstanceMethods

    def initialize(name)
        @name = name
        @opinions = []
    end

    def add_opinion(opinion)
        self.opinions << opinion
    end
    

end
