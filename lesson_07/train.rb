class Train
  include Manufacturer
  include InstanceCounter
  attr_accessor :speed, :route, :station
  attr_reader :number, :kind, :vans

  NUMBER_FORMAT = /^[a-z0-9]{3}\-*[a-z0-9]{2}$/i

  def initialize(number)
    @number = number
    validate!
    @kind = kind!
    @vans = []
    @speed = 0
    register_instance
  end

  def valid?
    validate!
  rescue
    false
  end

  def add_van(van) 
    raise "Before adding vans you should stop the train!" if speed > 0
    self.vans << van
  end

  def delete_van(van)
    raise "Before deleting vans you should stop the train!" if speed > 0
    self.vans.delete(van)
  end

  def move_to_next_station
    raise "Choose the route!" if route == nil || route.points.empty?
    
    index = station == nil ? 0 : route.points.index(station)+1
    raise "The train has already arrived to the end point!" if index > route.points.length-1

    next_station = route.points[index]
    next_station.add_train(self)
      
    station.leave(self) if station != nil 
    self.station = next_station
  end

  def current_point
    raise"Choose the route!" if route == nil || route.points.empty?

    current_index = route.points.index station
    puts " - #{route.points[current_index-1].name}" if current_index > 0
    puts " * #{station.name}"
    puts " - #{route.points[current_index+1].name}" if current_index != route.points.length-1
  end

  def select_vans
    self.vans.each { |item| yield(item) if block_given?}
  end
  
  protected

  attr_writer :kind, :vans
  
  def validate!
    raise "You should use classes PassengerTrain or CargoTrain." if self.class == Train
    raise "Number shouldn't be nil." if number.nil?
    raise "Number should be 5 or 6 characters." if number.length < 5 && number.length > 6
    raise "Number has invalid format. XXX-XX or XXXXX." if number !~ NUMBER_FORMAT
    true
  end
end

class PassengerTrain < Train
  
  def add_van(van)
    return puts "unexpected van for this train" if van.class != PassengerVan
    super 
  end

  protected

  def kind!
    "Passenger"
  end
end

class CargoTrain < Train
  
  def add_van(van)
    return puts "unexpected van for this train" if van.class != CargoVan
    super 
  end
  
  protected

  def kind!
    "Cargo"
  end
end
