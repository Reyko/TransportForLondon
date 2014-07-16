

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
    @array
  end

	def get_stations_name	
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
  	@lines = [Line.new("Victoria"),
              Line.new("Bakerloo"),
              Line.new("Central")]
  	
  	@lines[0].stations(
      Station.new("Kings Cross"),
	 	  Station.new("Euston"),
	  	Station.new("Warren Street"),
	 	  Station.new("Oxford Circus"),
	 	  Station.new("Green Park"),
	 	  Station.new("Victoria"),
	 	  Station.new("Pimlico"))

  	@lines[1].stations(
      Station.new("Elephant and Castle"),
      Station.new("Lambeth North"),
      Station.new("Waterloo"),
  	  Station.new("Embankment"),
  	  Station.new("Charing Cross"),
  	  Station.new("Picadilly Circus"),
  	  Station.new("Oxford Circus"),
  	  Station.new("Regent's Park"),
  	  Station.new("Baker Street"))

  	@lines[2].stations(
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

  def merge_lines
    stations = []
    @lines.each do |line|
      stations += line.get_stations 
    end
    stations
  end

  def get_stations_names
    stations = []
    merge_lines.each do |station|
      stations << station.name
      stations
    end
    stations.uniq.each do |station|
      yield station
    end
  end

  def find_stations(start_station,end_station)
    start_line = []
    end_line = []

    start_point = ""
    end_point = ""

    @lines.each do |line|
      line.get_stations.each do |station|
        if station.name == start_station
          start_point = station.name
          line.get_stations_name do |station|
            start_line << station
          end
        end
        if station.name == end_station
          end_point = station.name
          line.get_stations_name do |station|
            end_line << station
          end
        end 
      end
    end
    # binding.pry
    return start_line, end_line, start_point, end_point
  end


  def find_route(start_station, end_station)   
    start_line, end_line, start_point, end_point = find_stations(start_station, end_station)

    start_station_index = start_line.index(start_point)
    end_station_index = end_line.index(end_point)

    line_one = []
    line_two = []

    if start_line != end_line
      common_station = start_line & end_line
      common_station_start_index = start_line.index(common_station[0])
      common_station_end_index = end_line.index(common_station[0])

      if common_station_start_index > start_station_index
        line_one = start_line[start_station_index..common_station_start_index]
      else
        line_one = start_line[common_station_start_index..start_station_index].reverse
      end

      if common_station_end_index > end_station_index
        line_two = end_line[end_station_index..common_station_end_index].reverse
      else
        line_two = end_line[common_station_end_index..end_station_index]
      end
      route = (line_one + line_two).uniq
    else
      if start_station_index < end_station_index
        route = start_line[start_station_index..end_station_index]
      else
        route = start_line[end_station_index..start_station_index].reverse
      end
    end

    route
  end
end


class App
  def user_choice
    @tfl = Init.new
    @tfl.create_stations
    @prompt = "> "
    counter = 0

    puts "Hello! Please select the starting station that you wish"
    @tfl.get_stations_names do |station|
      counter+=1
      if counter<10
      puts "#{counter}.  #{station}"
      else
      puts "#{counter}. #{station}"
      end
    end
    counter = 0
    print @prompt
    start_station = gets.chomp.to_i - 1

    puts "Please select the end station that you wish"
    @tfl.get_stations_names do |station|
      counter += 1
      if counter < 10
      puts "#{counter}.  #{station}"
      else
      puts "#{counter}. #{station}"
      end
    end
    
    print @prompt
    end_station = gets.chomp.to_i - 1

    counter = 0
    @tfl.get_stations_names do |station|
      if start_station == counter
         start_station = station
      elsif end_station == counter
         end_station = station
      end
      counter+=1
    end

    counter = 0
    puts "Your route contains the following stations"
	  stations = @tfl.find_route(start_station,end_station)

      stations.each do |station|
        counter += 1
        if counter < 10
        puts "#{counter}.  #{station}"
        else
        puts "#{counter}. #{station}"
        end
      end

  end
end
	

my_app = App.new
my_app.user_choice()


