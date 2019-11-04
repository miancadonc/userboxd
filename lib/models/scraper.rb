load 'lib/concerns/findable.rb'
load 'lib/concerns/persistable.rb'
require 'pry'
require 'open-uri'
require 'nokogiri'
class Scraper
    BASE_PATH = "https://letterboxd.com/"
    def self.check_page(user)
        begin
            response = open(BASE_PATH + "#{user}/films/ratings/")
        rescue => e
           puts "THIS USER DOESN'T EXIST!"
           puts "returning to add users . . ."
           return nil
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
            html.css(".pagination .paginate-page a").each do |link|
                html = Nokogiri::HTML(open(BASE_PATH + link.attr("href")))
                html.css(".poster-container").each do |poster|
                    rating = poster.css(".poster-viewingdata span").text
                    film = poster.css(".film-poster").css("div").children[1].attr("alt")
                    Film.find_or_create_by_name(film)
                    Opinion.new(user,film,rating)
                end
            end
        end

    end
end