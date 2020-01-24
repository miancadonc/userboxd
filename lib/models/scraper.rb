class Scraper
    BASE_PATH = "https://letterboxd.com/"
    def self.check_page(user)
        begin
            response = open(BASE_PATH + "#{user}/films/ratings/")
        rescue => e
           puts "THIS USER DOESN'T EXIST!"
           puts "returning to add users . . ."
        end
        
    end

    def self.scrape_profile_page(user)
        html = Nokogiri::HTML(open(BASE_PATH + "#{user.name}/films/ratings"))
        pagination = html.css(".pagination")
        html.css(".poster-container").each do |poster|
            rating = poster.css(".poster-viewingdata span").text
            film = poster.css(".film-poster").css("div").children[1].attr("alt")
            Film.find_or_create_by_name(film)
            Opinion.new(user,film,rating)
         end
        if !!pagination == nil
            
        else
            page_number = html.css(".pagination .paginate-page").last.text.to_i
            (2..page_number).to_a.each do |page|
                html = Nokogiri::HTML(open(BASE_PATH + "#{user.name}/films/ratings/page/#{page}/"))
                html.css(".poster-container").each do |poster|
                    rating = poster.css(".poster-viewingdata span").text.strip
                    film = poster.css(".film-poster").css("div").children[1].attr("alt")
                    Film.find_or_create_by_name(film)
                    Opinion.new(user,film,rating)
                end
            end
        end

    end
end