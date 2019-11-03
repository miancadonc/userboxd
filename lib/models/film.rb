load 'lib/concerns/findable.rb'
load 'lib/concerns/persistable.rb'
class Film
    attr_accessor :name
    @@all = []

    def initialize(name)
        @name = name
    end

    def self.create(name)
        Film.new(name).save
    end

    def save
        @@all << self
    end


end
