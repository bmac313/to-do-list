module Controller
	
	def self.get_user_input
		print "Type a command here: "
		input = gets.chomp.downcase
		return input
	end
	
	# Creates a blank array and returns it. If the current array is not blank, users will
	# be warned that they're about to overwrite it.
	def self.create_new_list(list)
		
		if(list != []) #If list is not a blank array...
			confirmed = prompt_yes_or_no("Are you sure? You will lose any unsaved data.")
			
			if(confirmed)
				list = Array.new
				puts "A new list was created successfully."
			else
				puts "Cancelled."
			end
			
		else
			#initialize new instance of List class with an empty array as the items variable
			list = Array.new
			puts "A new list was created successfully."
		end
		return list
	end
	
	def self.add_task(list)
		print "Enter the task you want to add to the list: "
		task = gets.chomp
		list.push(task)
		return list
	end
	
	def self.delete_task(list)
		print "Enter the number of the task you want to delete: "
		task_number = gets.chomp
		confirmed = prompt_yes_or_no("Are you sure you want to delete that task?")
		
		if(confirmed)
			list.delete_at((task_number.to_i) - 1)
			puts "The task was deleted from your list."
		else
			puts "The task was not deleted."
		end
			
		return list
	end
	
	def self.update_task(list)
		print "Enter the number of the task you want to update: "
		task_number = gets.chomp
		print "Enter a new message for this task: "
		task_message = gets.chomp
		action_confirmed = prompt_yes_or_no("Are you sure you want to overwrite that task?")
		if(action_confirmed)
			list[(task_number.to_i) - 1] = task_message
			puts "The task was updated successfully"
		else
			puts "Cancelled."
		end
		return list
	end
	
	def self.show_list(list)
		if(list != []) #if list is not empty...
			index = 0
			puts " "
			list.each do |item|
				puts "#{index + 1}    #{item}"
				index += 1
			end
			puts " "
		else
			puts "There are no items in the list to show. Try adding some first!"
			puts " "
		end
	end
	
	def self.save_list(list)
		print "Please enter a file name (the extension will be added automatically): "
		file_name = gets.chomp
		#gets the current directory and attaches a relative path to the file
		file_path = "#{File.expand_path(File.dirname(__FILE__))}/data/#{file_name}.txt"
		if(File.exist?(file_path))
			confirmed = prompt_yes_or_no("'#{file_name}.txt' already exists. Would you like to replace it?")
			if(confirmed)
				tfile = File.open(file_path, "w")
				list.each do |item|
					tfile.puts "#{item}"			
				end
				puts "List saved at #{file_path}"
				tfile.close
			else
				puts "Cancelled."
			end
		else
			tfile = File.open(file_path, "w")
			list.each do |item|
				tfile.puts "#{item}"			
			end
			puts "List saved at #{file_path}"
			tfile.close
		end
	end
	
	def self.open_list
		print "Please enter the name of the file you wish to open (the extension will be added automatically): "
		list = Array.new #new array to be filled and returned
		i = 0 #array index
		file_name = gets.chomp
		file_path = "#{File.expand_path(File.dirname(__FILE__))}/data/#{file_name}.txt"
		if(File.exists?(file_path))
			tfile = File.open(file_path, "r")
			while !tfile.eof?
				list[i] = tfile.readline
				i += 1
			end
			tfile.close
			puts "'#{file_name}.txt' was loaded successfully."
		else
			puts "ERROR: The file could not be found. It may have been moved, deleted, or renamed."
		end
		
		return list
	end
	
	#takes in a yes or no question (string) for the prompt and adds '(y/n):' to it
	#returns true or false for 'yes' or 'no' respectively.
	def self.prompt_yes_or_no(question)
		result = false
		print "#{question} (y/n): "
		loop do
			response = gets.chomp
			if(response == "y")
				result = true
			elsif(response == "n")
				result = false
			else
				print "Please type 'y' or 'n': "
			end
		break if response == "y" || response == "n"
		end
		return result
	end
	
end

