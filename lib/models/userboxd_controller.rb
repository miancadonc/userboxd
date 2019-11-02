class UserboxdController

    VALID_INPUT = ['help', 'add user', 'display users', 'user info', 'compare users', 'exit']

    def start
        greeting
        menu_prompt
        exit
    end

    def greeting
        puts "-----------------------------------------"
        puts "Hello! Welcome to userboxd. Here, you can \nget information on letterboxd users and \ncompare them!"
        puts "-----------------------------------------"
    end

    def menu_prompt
        puts "What do you want to do?"
        puts "You can add a user, display your users," 
        puts "display one user's info, compare two users,"
        puts "or exit the program."
        puts "You can also type help for help typing the commands."
        puts "-----------------------------------------"
        input
    end

    def input
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
    end

    def exit
        puts "Goodbye!"
    end

    def help
        puts "display help message"
    end

    def add_user
        puts "add user"
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