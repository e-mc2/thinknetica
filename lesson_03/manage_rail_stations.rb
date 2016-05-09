class Station
  attr_accessor :trains
  attr_reader :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    if !trains.include? train
      self.trains << train
    end
  end

  def leave(train)
    self.trains.delete(train)
  end

  def show_all_trains
    self.trains.each {|item| puts item}
  end

  def show_trains_by_kind(kind)
    puts "List of \"#{kind}\" trains on #{name} station:"
    trains.each {|item| puts " - #{item.number }" if item.kind == kind }
  end

end

class Route
  attr_accessor :points

  def initialize(start_point, end_point)
    @points = []
    @points << start_point 
    @points << end_point
  end

  def add_point(point)
    self.points.insert(-2, point)
  end

  def delete_point(point)
    self.points.delete(point)
  end

  def show
    points.each {|item| puts " |-- " + item.name} 
  end

end

class Train
  attr_accessor :speed, :route, :station
  attr_reader :number, :kind, :vans

  def initialize(number, kind, vans)
    @number = number
    @kind = kind
    @vans = vans
    @speed = 0
  end
  
  def add_vans(value) 
    if speed == 0 
      vans += value
    else
      puts "before adding vans you should stop the train!"
    end
  end

  def move_to_next_station
    return puts "Choose the route!" if route == nil || route.points.empty?
    index = station == nil ? 0 : route.points.index(station)+1
    return puts "The train has already arrived to the end point!" if index > route.points.length-1

    next_station = route.points[index]
    next_station.add_train(self)
      
    station.leave(self) if station != nil 
    self.station = next_station
  end

  def current_point
    return puts "Choose the route!" if route == nil || route.points.empty?

    current_index = route.points.index station
    puts " - #{route.points[current_index-1].name}" if current_index > 0
    puts " * #{station.name}"
    puts " - #{route.points[current_index+1].name}" if current_index != route.points.length-1
  end

end
