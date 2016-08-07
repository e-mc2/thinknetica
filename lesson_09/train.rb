# basic class for the train object
class Train
  extend Accessor
  include Validation
  include InstanceCounter

  attr_reader :number, :kind, :speed
  attr_accessor_with_history :vans, :route, :station

  FORMAT = /^[a-z0-9]{3}\-*[a-z0-9]{2}$/i

  validate :number, :presence
  validate :number, :format, FORMAT, "XXX-XX or XXXXX"

  def initialize(number)
    @number = number
    @kind = kind!
    @vans = []
    @speed = 0
    validate!
    register_instance
  end

  def add_van(van)
    validate! speed, :equal, 0
    van_class = self.class == PassengerTrain ? PassengerTrain : PassengerVan
    validate! van, :type, van_class
    vans << van
  end

  def delete_van(van)
    validate! speed, :equal, 0
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
