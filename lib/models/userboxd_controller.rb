class UserboxdController

    VALID_INPUT = ['help', 'add users', 'display users', 'user info', 'compare users', 'exit']

    def start
        User.create("mianc")
        greeting
        menu_prompt
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
        puts "or exit the program."
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
        help if get_answer == "y"

    end

    def get_answer
        answer = gets.strip.downcase
        if answer == "y" || answer == "yes"
            "y"
        elsif answer == "n" || answer == "no"
            puts "Okay."
            input
        elsif answer == "exit"
            exit
        else
            invalid_input
        end
    end


    def exit
        puts "Goodbye!"
        line
    end

    def help
        puts "Here's a list of viable commands."
        line
        puts "display users"
        puts "add users"
        puts "user info"
        puts "compare users"
        puts "help"
        puts "exit"
        input
    end

    def get_username
        line
        puts "Please enter a letterboxd username:"
        username = gets.strip
        username == "done" ? input : add_user(username)
    end

    def add_user(username)
        if User.exists?(username) 
            puts "Youv'e already added that user!"
            get_username

            # elsif User.new(username).valid? == false
        #     puts "Looks like that user doesn't exit!"
        #     puts "Would you like to add another user? (y/n)"
        #     add_user if get_answer == "y"
        else 
            User.create(username)
            puts "#{username} added."
            get_username
        end
    end



    def add_users #NEEDS BETTER OPTIONS TO ADD ANOTHER USER
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
        puts "user info method here"
    end

    def compare_users
        puts "compare users method here"
    end




    

end
