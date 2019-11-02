class UserboxdController

    def start
        greeting
        menu_prompt
        goodbye
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
        menu
    end

    def menu
        input = gets.strip
    end


    def exit
        puts "Goodbye!"
    end


    

end
