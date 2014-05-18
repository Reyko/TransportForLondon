require 'pry'

class Line
	def initialize(name)
		@name = name
	end	

	def get_name
		@name
	end

	def stations(*array)
		@array = array
	end

	def get_stations	
	  @array.each do |station|
	  	yield station.name
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
  	@lines = {:victoria => Line.new("Victoria"), :bakerloo => Line.new("Bakerloo"), :central => Line.new("Central")}
  	
  	@lines[:victoria].stations(
                      Station.new("Kings Cross"),
          				 	  Station.new("Euston"),
          				  	Station.new("Warren Street"),
          				 	  Station.new("Oxford Circus"),
          				 	  Station.new("Green Park"),
          				 	  Station.new("Victoria"),
          				 	  Station.new("Pimlico"))

  	@lines[:bakerloo].stations(
                      Station.new("Elephant and Castle"),
                      Station.new("Lambeth North"),
                      Station.new("Waterloo"),
          			  	  Station.new("Embankment"),
          			  	  Station.new("Charing Cross"),
          			  	  Station.new("Picadilly Circus"),
          			  	  Station.new("Oxford Circus"),
          			  	  Station.new("Regent's Park"),
          			  	  Station.new("Baker Street"))

  	@lines[:central].stations(
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
		@lines.each do |line,value|
      yield value.get_name
		end
	end

  def get_lines
    @lines
  end


  def find_route(start_line,start_point,end_line,end_point)
  	stations = start_line.route
    # binding.pry
  	start_station_index = start_point.to_i - 1
    end_station_index = end_point.to_i - 1

    counter =0

    puts "Between #{stations[start_station_index].name} and #{stations[end_station_index].name}\n"
    puts "Your route contains the following stations:"

    if start_station_index < end_station_index
    	stops_names = stations[start_station_index..end_station_index]

      stops_names.each do |x|
        counter+=1
        puts "#{counter}. #{x.name}"
      end 

    else
      stops_names = stations[end_station_index..start_station_index]

      stops_names.reverse_each do |x|
        counter+=1
        puts "#{counter}. #{x.name}"
      end
    end

  
  end
end


class App
  def user_choice
    @tfl = Init.new
    @prompt = "> "
    puts "Hello! Please select the starting line that you wish"
    @tfl.create_stations
    counter = 0

    @tfl.line_selection do |line|
      counter += 1
      puts "#{counter}. #{line}"
    end
    counter = 0
    print @prompt 
    start_line = gets.chomp.to_i
    start_line, start_station = find_station(start_line)


    puts "Please select the ending line that you wish"
    @tfl.line_selection do |line|
      counter += 1
      puts "#{counter}. #{line}"
    end

    print @prompt
    end_line = gets.chomp.to_i
    end_station, end_station= find_station(end_line)

	  @tfl.find_route(start_line,start_station,end_line,end_station)
  end


  def find_station(line)
    counter = 0
    case line
    when 1
      @line = @tfl.get_lines[:victoria]

      puts "You have selected the #{@line.get_name} line. The following stations are available: \n"
      @line.get_stations do |station|
      counter+=1
      puts "#{counter}. #{station}"
    end
    when 2
      @line = @tfl.get_lines[:bakerloo]
    
      puts "You have selected the #{@line.get_name} line. The following stations are available: \n"
      @line.get_stations do |station|
      counter+=1
      puts "#{counter}. #{station}"
    end   
    when 3
      @line = @tfl.get_lines[:central]

      puts "You have selected the #{@line.get_name} line. The following stations are available: \n"
      @line.get_stations do |station|
      counter+=1
      puts "#{counter}. #{station}"
    end
    end

    print @prompt
    station = gets.chomp.to_i
    return @line, station
  end
end
	

my_app = App.new
my_app.user_choice()


