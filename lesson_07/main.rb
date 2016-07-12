require_relative 'manufacturer'
require_relative 'instance_counter'
require_relative 'train'
require_relative 'route'
require_relative 'station'
require_relative 'van_cargo'
require_relative 'van_passenger'

class Interface
  attr_accessor :trains, :stations, :vans

  def initialize
    @stations = []
    @trains = []
    @vans = []
  end

  def create_default_data!
    station_name = ['Moscow','Kursk','Saint Petersburg','Bologoe','Paris']

    station_name.each do |item|
      new_station = Station.new(item)

      rand(1..5).times do
        new_train = [CargoTrain, PassengerTrain].sample.new(generate_random_number(5).to_s)

        rand(1..7).times do
          new_van = (new_train.class == CargoTrain ? CargoVan : PassengerVan).new(generate_random_number(5), generate_random_number(2))
          new_train.add_van(new_van)
          self.vans << new_van
        end

        new_station.add_train(new_train)
        self.trains << new_train
      end

      self.stations << new_station
    end
  end

  def list_of_data
    self.stations.each do |station|
      puts "Station: #{station.name}"
      puts "----------------------"
      station.select_trains do |train|
        puts " - train no. #{train.number}, #{train.kind}, #{train.vans.count}"
        train.select_vans do |van|
          info = "free capacity: #{van.nofilled_part} gal, busy capacity: #{van.filled_part} gal" if van.class == CargoVan
          info = "free seats: #{van.count_free_seats}, busy seats: #{van.count_busy_seats}" if van.class == PassengerVan
          puts "   - van no. #{van.number}, #{van.kind}, #{info}"
        end
        puts
      end
    end
    nil
  end

  def run
    loop do
      puts "Choose what do whant to do:"
      puts "1 - Create a station"
      puts "2 - Create a train"
      puts "3 - Create a van"
      puts "4 - Add a van to a train"
      puts "5 - Delete a van from a train"
      puts "6 - Change a station of a train"
      puts "7 - Show list of stations"
      puts "8 - Show list of trains on a station"
      puts "9 - Quite"

      choise = gets.chomp.to_i

      case choise
      when 1
        create_station
      when 2
        create_train
      when 3
        create_van
      when 4
        add_van_to_train
      when 5
        delete_van_from_train
      when 6
        change_station
      when 7
        list_of_station
      when 8
        list_of_train
      when 9
        break
      end
    end
  end

  private

  def generate_random_number(n)
    new_number = Random.rand(10**n - 10**(n-1)) + 10**(n-1)
  end

  def create_station
    puts "Station's Name:"
    name_station = gets.chomp.to_s
    station = Station.new(name_station)
    stations << station
  end

  def create_train

    begin
      puts "Kind of train (1-Cargo; 2-Passenger):"
      kind_train = gets.chomp.to_s
      raise 'Kind should be 1 or 2' if kind_train !~ /[1-2]{1}/
    rescue RuntimeError => e
      puts "#{e.message}"
      retry
    end

    begin
      puts "Number of train:"
      number_train = gets.chomp.to_s

      train = kind_train == '1' ? CargoTrain.new(number_train) : PassengerTrain.new(number_train)
      self.trains << train

      puts "#{train.class} (no. #{train.number}) has created"
    rescue RuntimeError => e
      puts "#{e.message} Try again."
      retry
    end

  end

  def create_van
    puts "Kind of van (1-Cargo; 2-Passenger):"
    kind_van = gets.chomp.to_i
    puts "Number of van:"
    number_van = gets.chomp.to_i
    case kind_van
    when 1
      puts "Capacity:"
      capacity = gets.chomp.to_i
    when 2
      puts "Amount of seats:"
      seats = gets.chomp.to_i
    end

    van = kind_van == 1 ? CargoVan.new(number_van, capacity) : PassengerVan.new(number_van, seats)
    vans << van
  end

  def add_van_to_train
    puts "Choose a van: "
    vans.each_with_index {|item, index| puts " #{index} - #{item.number}, #{item.kind}"}
    index_van = gets.chomp.to_i

    puts "Choose a train: "
    trains.each_with_index {|item, index| puts " #{index} - #{item.number}, #{item.kind}"}
    index_train = gets.chomp.to_i

    trains[index_train].add_van(vans[index_van])
  end

  def delete_van_from_train
    puts "Choose a train: "
    trains.each_with_index {|item, index| puts " #{index} - #{item.number}, #{item.kind}"}
    index_train = gets.chomp.to_i

    train = trains[index_train]
    puts "Train - number: #{train.number}, kind: #{train.kind}"

    train.vans.each_with_index {|item, index| puts " #{index} - #{item.number}, #{item.kind}"}
    puts "Choose van for deleting: "
    index_van = gets.chomp.to_i

    train.delete_van(train.vans[index_van])
  end

  def change_station
    puts "Choose a station: "
    stations.each_with_index {|item, index| puts " #{index} - #{item.name}"}
    index_station = gets.chomp.to_i

    puts "Choose a train: "
    trains.each_with_index {|item, index| puts " #{index} - #{item.number}, #{item.kind}"}
    index_train = gets.chomp.to_i

    trains[index_train].station = stations[index_station]
  end

  def list_of_station
    puts "List of stations:"
    stations.each {|item| puts " - #{item.name}"}
  end

  def list_of_train
    puts "Choose a station: "
    stations.each_with_index {|item, index| puts " #{index} - #{item.name}"}
    index_station = gets.chomp.to_i

    station = stations[index_station]
    puts "Station - #{station.name}"

    trains.each do |item|
      puts " - #{item.number}, #{item.kind}" if item.station == station
    end
  end

end
