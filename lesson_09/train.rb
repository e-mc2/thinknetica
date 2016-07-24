# basic class for the train object
class Train
  include Manufacturer
  include InstanceCounter
  attr_accessor :speed, :route, :station
  attr_reader :number, :kind, :vans

  FORMAT = /^[a-z0-9]{3}\-*[a-z0-9]{2}$/i

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
    raise 'Before adding vans you should stop the train!' if speed > 0
    vans << van
  end

  def delete_van(van)
    raise 'Before deleting vans you should stop the train!' if speed > 0
    vans.delete(van)
  end

  def move_to_next_station
    check_out_before_moving
    next_station = route.points[index]
    next_station.add_train(self)
    station.leave(self) unless station.nil?
    self.station = next_station
  end

  def current_point
    raise'Choose the route!' if route.nil? || route.points.empty?

    current_index = route.points.index station
    its_not_last = current_index != route.points.length - 1
    puts " - #{route.points[current_index - 1].name}" if current_index > 0
    puts " * #{station.name}"
    puts " - #{route.points[current_index + 1].name}" if its_not_last
  end

  def select_vans
    vans.each { |item| yield(item) if block_given? }
  end

  protected

  attr_writer :kind, :vans

  def validate!
    its_train = self.class == Train
    proper_length = number.length < 5 && number.length > 6
    raise 'You should use classes PassengerTrain or CargoTrain.' if its_train
    raise 'Number shouldn\'t be nil.' if number.nil?
    raise 'Number should be 5 or 6 characters.' if proper_length
    raise 'Number has invalid format. XXX-XX or XXXXX.' if number !~ FORMAT
    true
  end

  private

  def check_out_before_moving
    raise 'Choose the route!' if route.nil? || route.points.empty?
    index = station.nil? ? 0 : route.points.index(station) + 1
    train_arrived = index > route.points.length - 1
    raise 'The train has already arrived to the end point!' if train_arrived
  end
end

# class for creating a passenger train
class PassengerTrain < Train
  def add_van(van)
    return puts 'unexpected van for this train' if van.class != PassengerVan
    super
  end

  protected

  def kind!
    'Passenger'
  end
end

# class for creating a cargo train
class CargoTrain < Train
  def add_van(van)
    return puts 'unexpected van for this train' if van.class != CargoVan
    super
  end

  protected

  def kind!
    'Cargo'
  end
end
