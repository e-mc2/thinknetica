require_relative 'modules/manufacturer'
require_relative 'modules/instance_counter'
require_relative 'modules/actions'
require_relative 'station'
require_relative 'route'
require_relative 'station'
require_relative 'train'
require_relative 'van_cargo'
require_relative 'van_passenger'

# Main interface with greeting
class Interface
  include Actions
  attr_accessor :trains, :stations, :vans

  INTERFACE_METHODS = %w(create_station create_train create_van
                         add_van_to_train delete_van_from_train
                         change_station list_of_station list_of_train).freeze
  def initialize
    @stations = []
    @trains = []
    @vans = []
  end

  def create_random_vans(new_train)
    proper_vans = { 'Cargo' => CargoVan, 'Passenger' => PassengerVan }
    rand(1..7).times do
      kind_van = proper_vans[new_train.kind]
      new_van = kind_van.new(random_number(5), random_number(2))
      new_train.add_van(new_van)
      vans << new_van
    end
  end

  def create_random_trains(new_station)
    rand(1..5).times do
      new_train = [CargoTrain, PassengerTrain].sample.new(random_number(5).to_s)
      create_random_vans(new_train)
      new_station.add_train(new_train)
      trains << new_train
    end
  end

  def create_default_data!
    station_name = %w(Moscow Kursk Saint\ Petersburg Bologoe Paris)
    station_name.each do |item|
      new_station = Station.new(item)
      create_random_trains(new_station)
      stations << new_station
    end
  end

  def select_vans_of_train(train)
    train.select_vans do |van|
      first = van.class == CargoVan ? van.nofilled_part : van.count_free_seats
      second = van.class == CargoVan ? van.filed_part : van.count_busy_seats
      info = "free: #{first}, busy: #{second}"
      puts "   - van no. #{van.number}, #{van.kind}, #{info}"
    end
  end

  def list_of_data
    stations.each do |station|
      puts "Station: #{station.name}"
      station.select_trains do |train|
        puts " - train no. #{train.number}, #{train.kind}, #{train.vans.count}"
        select_vans_of_train(train)
      end
    end
  end

  def run
    loop do
      greeting
      choise = gets.chomp.to_i
      break if choise > 8 || choise < 1
      send(INTERFACE_METHODS[choise - 1])
    end
  end

  private

  def greeting
    puts 'Choose what do whant to do:'
    puts '1 - Create a station'
    puts '2 - Create a train'
    puts '3 - Create a van'
    puts '4 - Add a van to a train'
    puts '5 - Delete a van from a train'
    puts '6 - Change a station of a train'
    puts '7 - Show list of stations'
    puts '8 - Show list of trains on a station'
    puts '9 - Quite'
  end

  def random_number(n)
    Random.rand(10**n - 10**(n - 1)) + 10**(n - 1)
  end
end
