#------------------------------------------#
#       TO-DO LIST FOR PROGRAM             #
# > Improve readability of output.         #
# > Modify the list array in place instead #
#   of returning it (if possible).         #
# > Add conditional for if the user tries  #
#   to access a nonexistent slot in the    #
#   array.                                 #
# > Use ternary expressions when possible  #
# > Open file window instead of typing(?)  #
#                                          #
#------------------------------------------#

require_relative 'controller.rb'

$current_list = []

#Control flow of the whole program
def main
	cmd = " "
	
	show_app_header
	show_main_menu
	
	#main loop for program
	loop do
		cmd = parse_command(Controller.get_user_input)
		break if cmd == "exited"
	end
end

#Shows the header for the program
def show_app_header
	puts " "
	puts "----INTERACTIVE TO-DO LIST, v0.1.1----"
	puts "copyright Brendan McRae, 2016"
	puts " "
end

#Shows all options on the main menu
def show_main_menu
	puts "What would you like to do? Select an option from the list by typing its corresponding command."
	puts "(An empty to-do list has already been created for you.)"
	puts " "
	puts "----"
	puts "create       Create a new to-do list"
	puts "add          Add a task to the list"
	puts "delete       Delete a task from the list"
	puts "update       Update a task on the list"
	puts "show         Show all tasks in the list"
	puts "save         Save the current list as a text file"
	puts "open         Open a saved list from a text file"
	puts "help         Show all available options"
	puts "exit         Exit the program."
	puts "----"
	puts " "
end

#def get_user_input
#	print "Type a command here: "
#	input = gets.chomp
#	return input
#end

def parse_command(cmd)
	case cmd
		when 'create'
			$current_list = Controller.create_new_list($current_list)
			puts " "
		when 'add'
			$current_list = Controller.add_task($current_list)
			puts "The task was added to your list."
			puts " "
		when 'delete'
			$current_list = Controller.delete_task($current_list)
			puts " "
		when 'update'
			$current_list = Controller.update_task($current_list)
			puts " "
		when 'show'
			Controller.show_list($current_list)
		when 'save'
			Controller.save_list($current_list)
			puts " "
		when 'open'
			$current_list = Controller.open_list
			puts " "
		when 'help'
			show_main_menu
		when 'exit'
			if($current_list != [])
				confirmed = Controller.prompt_yes_or_no("Are you sure you want to exit? You will lose any unsaved data.")
				if(confirmed)
					cmd = "exited"
					puts " "
					puts "Goodbye!"
				else
					puts "Cancelled"
				end
			else
				cmd = "exited"
				puts " "
				puts "Goodbye!"
			end
		else
			puts "That isn't a valid command. Check your spelling!"
			puts " "
	end
	return cmd
end

#Call the main method. The program cannot run without this; DO NOT REMOVE!
main