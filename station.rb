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
	def route
		@array
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


class Init
  def create_stations
  	lines = [Line.new("Victoria"), Line.new("Bakerloo"), Line.new("Central")]

  	victoria = lines[0]
  	bakerloo = lines[1]
  	central  = lines[2]
  	
  	victoria.stations(
              Station.new("Kings Cross"),
  				 	  Station.new("Euston"),
  				  	Station.new("Warren Street"),
  				 	  Station.new("Oxford Circus"),
  				 	  Station.new("Green Park"),
  				 	  Station.new("Victoria"),
  				 	  Station.new("Pimlico"))

  	bakerloo.stations(
              Station.new("Elephant and Castle"),
              Station.new("Lambeth North"),
              Station.new("Waterloo"),
  			  	  Station.new("Embankment"),
  			  	  Station.new("Charing Cross"),
  			  	  Station.new("Picadilly Circus"),
  			  	  Station.new("Oxford Circus"),
  			  	  Station.new("Regent's Park"),
  			  	  Station.new("Baker Street"))

  	central.stations(
              Station.new("Notting Hill"),
  			     	Station.new("Queensway"),
  			     	Station.new("Lancaster Gate"),
  				 	  Station.new("Marble Arch"),
  				 	  Station.new("Bond Street"),
  				 	  Station.new("Oxford Circus"),
  				 	  Station.new("Tottenham Court Road"), 
  				 	  Station.new("Holborn"),
  				 	  Station.new("Chancery Lane"))
  end

	def line_selection
		counter=1
		$lines.each do |x|
		puts "#{counter} #{x.get_line}"
		counter+=1
		end
	end

  def find_route(start_line,start_point,end_line,end_point)
  	case start_line
		when "1"
			start_line = $victoria
		when "2"
			start_line = $bakerloo
		when "2"   			 
			start_line = $central
  	end 

  	case end_line
		when "1"
			end_line = $victoria
		when "2"
			end_line = $bakerloo
		when "2"   			 
			end_line = $central
  	end 

  	stations = start_line.route
  
  	start_station_index = start_point.to_i - 1
  	initial_station = stations[start_station_index]

  	end_station_index = end_point.to_i - 1
  	final_station = stations[end_station_index]

  	stops=0
  	bool = false
  	stations.each do |x|
  		if bool
  			stops+=1
  		end
  		if x.name == initial_station.name
  			bool = true
  		end
  		if x.name == final_station.name
  			bool = false
  		end
  	end	
  	
  	limiter = stops
  	stops -=1


  	stops_names = stations[start_station_index,limiter]

  	puts "Betweem #{stations[start_station_index].name} and #{stations[end_station_index].name} the number of stops are #{stops}\n"
  	puts "Your route contains the following stations:"

  	counter=0
  	stops_names.each do |x|
  		next if x.name == initial_station.name
  		counter+=1
  		puts "#{counter}. #{x.name}"
  	end
  end
end


class App
	  @prompt = "> "
	  puts "Hello! Please select the starting line that you wish by number"
	  line_selection
	  print @prompt
	  $start_line = gets.chomp
    @station = "The following stations are available for you\nPlease select the starting station that you wish"
 
    def user_choice
    	end_line = "Please select the ending line that you wish"
		  print @prompt
	    start_point = gets.chomp
	    
	    puts end_line
	    line_selection
	    
	    print @prompt
	    end_line = gets.chomp
	    
	    if end_line == "1"
	     end_line = $victoria
	    elsif end_line == "2"
	     end_line = $bakerloo
	    elsif end_line == "3"
	     end_line = $central
	    end
	    		
	    puts @station
	    end_line.get_stations

	    print @prompt
		  end_point = gets.chomp
		  find_route($start_line,start_point,end_line,end_point)
    end

  	case $start_line
  	   
  	   when "1"
   	    puts "You have selected the #{$victoria.get_line} line \n"
   	    puts @station
  			$victoria.get_stations
  			user_choice

  	   when "2"
     		puts "You have selected the #{$bakerloo.get_line} line \n"
     		puts @station
     		$bakerloo.get_stations
     		user_choice
  	 
  	   when	"3"
     		puts "You have selected the #{$central.get_line} line \n"
     		puts @station
     		$central.get_stations
     		user_choice
  	end
end
	



