class User
    attr_accessor :name
    @@all = []
    #extend Persistable::ClassMethods
    #include Persistable::InstanceMethods
    #extend Findable

    def initialize(name)
        self.name = name
    end


    def self.all
        @@all
    end

    def self.find_by_name(name)
        all.find{|user| user.name == name}
    end

    def self.exists?(username)
        !!find_by_name(username)
    end

    def save
        @@all << self
    end

    def self.create(username)
        new(username).save
    end


end
