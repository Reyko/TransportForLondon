class Line
	def initialize(name)
		@name = name
	end	
	def get_line
		@name
	end
	def stations(*array)
		@array = array
	end
	def get_stations	
	  counter = 1	
	  @array.each do |x|
	  	puts "#{counter} #{x.name}"
	  	counter+=1
	  end
	end
end



class Station
	def initialize(name)
		@name = name
	end
	def name
		@name
	end
end


	lines = [Line.new("Victoria"), Line.new("Bakerloo"), Line.new("Central")]

	victoria = lines[0]
	bakerloo = lines[1]
	central =  lines[2]
	

	
	victoria.stations(Station.new("Kings Cross"),
				 	  Station.new("Euston"),
				  	  Station.new("Warren Street"),
				 	  Station.new("Oxford Circus"),
				 	  Station.new("Green Park"),
				 	  Station.new("Victoria"),
				 	  Station.new("Pimlico"))


	bakerloo.stations(Station.new("Elephant and Castle"),
	              	  Station.new("Lambeth North"),
	             	  Station.new("Waterloo"),
				  	  Station.new("Embankment"),
				  	  Station.new("Charing Cross"),
				  	  Station.new("Picadilly Circus"),
				  	  Station.new("Oxford Circus"),
				  	  Station.new("Regent's Park"),
				  	  Station.new("Baker Street"))


	central.stations(Station.new("Notting Hill"),
			     	 Station.new("Queensway"),
			     	 Station.new("Lancaster Gate"),
				 	 Station.new("Marble Arch"),
				 	 Station.new("Bond Street"),
				 	 Station.new("Oxford Circus"),
				 	 Station.new("Tottenham Court Road"), 
				 	 Station.new("Holborn"),
				 	 Station.new("Chancery Lane"))



#victoria.get_stations
	

	def line_selection(lines)
		counter=1
		lines.each do |x|
		 puts "#{counter} #{x.get_line}"
		counter+=1
		end
	end



	@prompt = "> "
	puts "Hello! Please select the starting line that you wish by number"
	line_selection(lines)
	print @prompt
	start_line = gets.chomp
    @station = "The following stations are available for you\nPlease select the starting station that you wish"
    # station = "The following stations are available for you\nPlease select the end station that you wish"
   


    def user_choice(lines,victoria,bakerloo,central)
    	end_line = "Please select the ending line that you wish"
		print @prompt
	    start_point = gets.chomp
	    
	    puts end_line
	    line_selection(lines)
	    
	    print @prompt
	    end_line = gets.chomp
	    
	    if end_line == "1"
	    	end_line = victoria
	    elsif end_line == "2"
	    	end_line = bakerloo
	    elsif end_line == "3"
	    	end_line = central
	    end
	    		
	    puts @station
	    end_line.get_stations


	    print @prompt
		end_point = gets.chomp
    end



	case start_line
	   
	   when "1"
	   	    puts "You have selected the #{victoria.get_line} line \n"
	   	    puts @station
			victoria.get_stations
			user_choice(lines,victoria,bakerloo,central)

	   when "2"
	   		puts "You have selected the #{bakerloo.get_line} line \n"
	   		puts @station
	   		bakerloo.get_stations
	   		user_choice(lines,victoria,bakerloo,central)

	 
	   when	"3"
	   		puts "You have selected the #{central.get_line} line \n"
	   		puts @station
	   		central.get_stations
	   		user_choice(lines,victoria,bakerloo,central)
	end
		





