load 'lib/concerns/findable.rb'
load 'lib/concerns/persistable.rb'
class Opinion
    attr_accessor :film, :rating, :user
    extend Persistable::ClassMethods, Findable
    include Persistable::InstanceMethods
    def initialize (user, film, rating)
        @user = user
        user.add_opinion(self)
        @film = film
        @rating = rating
    end
end
