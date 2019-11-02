class UserboxdController

    VALID_INPUT = ['help', 'add user', 'display users', 'user info', 'compare users', 'exit']

    def start
        #User.create(mianc)
        greeting
        menu_prompt
    end

    def greeting
        puts "-----------------------------------------"
        puts "Hello! Welcome to userboxd. Here, you can \nget information on letterboxd users and \ncompare them!"
        puts "-----------------------------------------"
    end

    def menu_prompt
        puts "You can add a user, display your users," 
        puts "display one user's info, compare two users,"
        puts "or exit the program."
        puts "You can also type help for help typing the commands."
        input
    end

    def input
        puts "-----------------------------------------"
        puts "What would you like to do?"
        input = gets.strip.downcase
        valid_input?(input)
    end

    def valid_input?(input)
        VALID_INPUT.include?(input) ? evalutate_input(input) : invalid_input
    end

    def evalutate_input(input)
        #method = input.gsub(" ","_")

        case input
        when "exit"
            exit
        when "help"
            help
        when "add user"
            add_user
        when "display users"
            display_users
        when "user info"
            user_info
        when "compare users"
            compare_users
        end

    end

    def invalid_input
        puts "I'm sorry, but I didn't understand what you wrote."
        puts "Would you like some help? (y/n)"
        help if get_answer == "y"

    end

    def get_answer
        answer = gets.strip.downcase
        if answer == "y" || answer == "yes"
            "y"
        elsif answer == "n" || answer == "no"
            puts "Okay."
            input
        else
            invalid_input
        end
    end


    def exit
        puts "Goodbye!"
    end

    def help
        puts "Here's a list of viable commands."
        puts "display users"
        puts "add user"
        puts "user info"
        puts "compare users"
        puts "help"
        puts "exit"
        input
    end

    def add_user
        puts "Please enter a letterboxd username:"
        username = gets.strip
        if User.exists?(username) 
            puts "Youv'e already added that user!"
            input
        # elsif User.new(username).valid? == false
        #     puts "Looks like that user doesn't exit!"
        #     puts "Would you like to add another user? (y/n)"
        #     add_user if get_answer == "y"
        else 
            User.create(username)
            puts "#{username} added."
            puts "-----------------------------------------"
            puts "Would you like to add another user? (y/n)"
            add_user if get_answer == "y"
        end
    end

    def display_users
        puts "display users"
    end

    def user_info
        puts "user info"
    end

    def compare_users
        puts "compare users"
    end




    

end
