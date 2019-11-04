require 'pry'
class UserboxdController

    VALID_INPUT = ['help', 'add users', 'display users', 'user info', 'compare users', 'clear users', 'exit']
    BASE_PATH = "https://letterboxd.com/"

    def start
        mianc = User.new("mianc")
        make_user(mianc)
        greeting
        menu_prompt
    end

    def make_user(user)
        Scraper.scrape_profile_page(user)
    end

    def line
        puts "-----------------------------------------"
    end


    def greeting
        line
        puts "Hello! Welcome to userboxd. Here, you can \nget information on letterboxd users and \ncompare them!"
        line
    end

    def menu_prompt
        puts "You can add users, display your users," 
        puts "display one user's info, compare two users,"
        puts "clear your users, or exit the program."
        puts "You can also type help for help typing the commands."
        input
    end

    def input
        line
        puts "What would you like to do?"
        line
        input = gets.strip.downcase
        valid_input?(input)
    end

    def valid_input?(input)
        VALID_INPUT.include?(input) ? evalutate_input(input) : invalid_input
    end

    def evalutate_input(input)
        method = input.gsub(" ","_")
        self.send("#{method}")
    end

    def invalid_input
        puts "I'm sorry, but I didn't understand what you wrote."
        puts "Would you like some help? (y/n)"
        line
        answer = gets.strip.downcase
        if  answer == "y"
            help 
        elsif answer == "n"
            okay
        else
            invalid_input
        end

    end

    def get_answer
        answer = gets.strip.downcase
        if answer == "y" || answer == "yes"
            "y"
        elsif answer == "n" || answer == "no"
            "n"
        elsif answer == "exit"
            exit
        else
            invalid_input
        end
    end

    def okay
        puts "Okay! Returning you to the main menu."
        input
    end

    def exit
        puts "Goodbye!"
        line
        exit!
    end

    def help
        puts "Here's a list of viable commands."
        line
        VALID_INPUT.each {|command| puts command}
        input
    end

    def get_username
        line
        puts "Please enter a letterboxd username or type 'done':"
        username = gets.strip
        username == "done" ? input : add_user(username)
    end

    def add_user(username)
        if User.exists?(username) 
            puts "Youv'e already added that user!"
            get_username
        else 
            if Scraper.check_page(username) == nil
                add_users
            else
                user = User.new(username)
                make_user(user)
                puts "#{username} added."
                get_username
            end
        end
    end



    def add_users
        line
        puts "Add as many users as you want, adding them one at a time."
        puts "When you're done, type \"done\""
        get_username
    end

    def display_users
        line
        puts "Here are your added users:"
        User.all.each {|user| puts "#{user.name}"}
        input
    end

    def user_info
        line
        puts "What user would you like more info on?"
        answer = gets.strip
        user = User.find_by_name(answer)
        !!User.find_by_name(answer) ? get_info(user) : no_user(answer)
    end

    def get_info(user)
        line
        five_star = user.opinions.select{|o|o.rating == "★★★★★"}.size
        puts "Here's some more information on #{user.name}."
        puts "Films rated: #{user.opinions.size}"
        puts "Five star rated films: #{five_star}"
        puts "Would you like to see how they felt about a particular film?"
        user_film(user) if get_answer == "y"
        input
    end

    def user_film(user)
        line
        puts "Here are the films that #{user.name} has rated, 10 at a time."
        if user.opinions.size == 0
            puts "This user has no films rated!"
            okay
        elsif user.opinions.size <10
            small_display_films(user)
        else
            select_films(user)
        end
        puts "Do you want to see more films? If you want to choose a film, type 'n' (y/n)"
        if get_answer == "y"
            user_film(user) 
        else 
            choose_film(user) 
        end
    end

    def small_display_films(user)
        user.opinions.each.with_index do |opinion, index|
            puts "#{index}. #{opinion.film.name}"
        end
    end

    def select_films(user)
        puts "To select which 10 appear at a time, type a starting number:"
        input = gets.strip.to_i - 1
        display_films(user, input)
    end

    def display_films(user, input)
        line
        user.opinions[input, 10].each.with_index do |opinion, index|
            puts "#{index+input+1}. #{opinion.film.name}"
        end
    end

    def choose_film(user)
        puts "Please enter the number of the film you want to choose:"
        input = gets.strip.to_i-1
        line
        puts "#{user.name} watched #{user.opinions[input].film.name} and rated it #{user.opinions[input].rating}"
    end

    def no_user(answer)
        puts "You haven't added that user yet! Would you like to? (y/n)"
        response = get_answer
        if response == "y"
            add_users
        else
            input
        end
    end

    def clear_users
        User.all.clear
        Opinion.all.clear
        input
    end

    def compare_users
        line
        puts "Enter user 1:"
        user_1 = get_user
        puts "Enter user 2:"
        user_2 = get_user
        comparing_users(user_1, user_2)
    end

    def get_user
        name = gets.strip
        if User.exists?(name)
            user = User.find_by_name(name)
        elsif name == "exit"
            okay
        else
            puts "I'm sorry, that didn't register as a user."
            puts "Please enter a user or type 'exit'."
            line
            get_user
        end

    end

    def comparing_users(user_1, user_2)
        puts "You can compare the two users to see who's watched more movies,"
        puts "Or, you can see who liked a particular movie better."
        puts "Type 'more movies' or 'liked better' or 'exit'."
        answer = gets.strip.downcase
        if answer == 'more movies'
            more_movies(user_1, user_2)
        elsif answer == 'liked better'
            liked_better(user_1, user_2)
        elsif answer == 'exit'
            okay
        else
            puts "I'm sorry, I didn't understand that."
            sleep(2)
            comparing_users(user_1, user_2)
        end
    end

    def more_movies(user_1, user_2)
        line
        sleep(2)
        if user_1.opinions.size == user_2.opinions.size
            puts "Looks like they've both watched #{user_1.opinions.size} movies!"
            sleep(2)
            input
        elsif user_1.opinions.size > user_2.opinions.size
            puts "Looks like #{user_1.name} is the film genius here!"
            puts "They've watched #{user_1.opinions.size} films while #{user_2.name} has only watched #{user_2.opinions.size}"
            sleep(2)
            input
        else
            puts "Looks like #{user_2.name} is the filmg genius here!"
            puts "They've watched #{user_2.opinions.size} films while #{user_1.name} has only watched #{user_1.opinions.size}"
            sleep(2)
            input
        end
    end

    def liked_better(user_1, user_2)
        line
        puts "Please type in a film name. \nIt might be easier to copy and paste from a list."
        movie = gets.strip
        user_1_opinion = user_1.opinions.find{|o|o.film.name == movie}
        user_2_opinion = user_2.opinions.find{|o|o.film.name == movie}
        if !!user_1_opinion && !!user_2_opinion
            puts "#{user_1.name} rated #{movie.name} #{user_1_opinion.rating} while #{user_2} rated it #{user_2_opinion.rating}."
        elsif !!user_1_opinion && !!user_2_opinion == false
            puts "Only #{user_1.name} has watched this film!"
            puts "Better step up your game, #{user_2.name}!"
        elsif !!user_2_opinion && !!user_1_opinion == false
            puts "Only #{user_2.name} has watched this film!"
            puts "Better step up your game, #{user_1.name}!"
        else
            puts "Neither user has watched this movie."
        end
        input
    end
end
