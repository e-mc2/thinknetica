require_relative 'route'
require_relative 'train'
require_relative 'station'
require_relative 'van'

stations = []
trains = []
vans = []

loop do

  #system "clear"

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

    puts "Station's Name:"
    name_station = gets.chomp.to_s
    station = Station.new(name_station)
    stations << station

  when 2

    puts "Kind of train (1-Cargo; 2-Passenger):"
    kind_train = gets.chomp.to_i
    puts "Number of train:"
    number_train = gets.chomp.to_i
    train = kind_train == 1 ? CargoTrain.new(number_train) : PassengerTrain.new(number_train)
    trains << train

  when 3
    
    puts "Kind of van (1-Cargo; 2-Passenger):"
    kind_van = gets.chomp.to_i
    puts "Number of van:"
    number_van = gets.chomp.to_i
    van = kind_van == 1 ? CargoVan.new(number_van) : PassengerVan.new(number_van)
    vans << van
  
  when 4
    
    puts "Choose a van: "
    vans.each_with_index {|item, index| puts " #{index} - #{item.number}, #{item.kind}"}
    index_van = gets.chomp.to_i

    puts "Choose a train: "
    trains.each_with_index {|item, index| puts " #{index} - #{item.number}, #{item.kind}"}
    index_train = gets.chomp.to_i

    trains[index_train].add_van(vans[index_van])

  when 5 

    puts "Choose a train: "
    trains.each_with_index {|item, index| puts " #{index} - #{item.number}, #{item.kind}"}
    index_train = gets.chomp.to_i
    
    train = trains[index_train]
    puts "Train - number: #{train.number}, kind: #{train.kind}"
    
    train.vans.each_with_index {|item, index| puts " #{index} - #{item.number}, #{item.kind}"}
    puts "Choose van for deleting: "
    index_van = gets.chomp.to_i

    train.delete_van(train.vans[index_van])

  when 6

    puts "Choose a station: "
    stations.each_with_index {|item, index| puts " #{index} - #{item.name}"}
    index_station = gets.chomp.to_i

    puts "Choose a train: "
    trains.each_with_index {|item, index| puts " #{index} - #{item.number}, #{item.kind}"}
    index_train = gets.chomp.to_i

    trains[index_train].station = stations[index_station]

  when 7

    puts "List of stations:"
    stations.each {|item| puts " - #{item.name}"}

  when 8

    puts "Choose a station: "
    stations.each_with_index {|item, index| puts " #{index} - #{item.name}"}
    index_station = gets.chomp.to_i

    station = stations[index_station]
      puts "Station - #{station.name}"

    trains.each do |item|
      puts " - #{item.number}, #{item.kind}" if item.station == station
    end

  when 9
    break
  end  
    

end
