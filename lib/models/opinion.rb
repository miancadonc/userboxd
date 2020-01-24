class Opinion

    attr_accessor :film, :rating, :user, :review
    extend Persistable::ClassMethods, Findable
    include Persistable::InstanceMethods

    def initialize (user, film, rating, review = "No review")
        @user = user
        user.add_opinion(self)
        @film = Film.find_or_create_by_name(film)
        @rating = rating
        self.save
    end
end
