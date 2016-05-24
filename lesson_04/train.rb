class Train
  attr_accessor :speed, :route, :station
  attr_reader :number, :kind, :vans

  def initialize(number)
    @number = number
    @kind = kind!
    @vans = []
    @speed = 0
  end
  
  def add_van(van) 
    return puts "before adding vans you should stop the train!" if speed > 0
    self.vans << van
  end

  def delete_van(van)
    return puts "before deleting vans you should stop the train!" if speed > 0
    self.vans.delete(van)
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
  
  protected

  attr_writer :kind, :vans
  
  def kind!
    "Base"
  end
end

class PassengerTrain < Train
  
  def add_van(van)
    return puts "unexpected van for this train" if van.class.name != "PassengerVan"
    super 
  end

  protected

  def kind!
    "Passenger"
  end
end

class CargoTrain < Train
  
  def add_van(van)
    return puts "unexpected van for this train" if van.class.name != "CargoVan"
    super 
  end
  
  protected

  def kind!
    "Cargo"
  end
end
