# actions wich are used in main interface
module Actions
  private

  def create_station
    puts 'Station\'s Name:'
    name_station = gets.chomp.to_s
    station = Station.new(name_station)
    stations << station
  end

  def choose_kind_of_train
    puts 'Kind of train (1-Cargo; 2-Passenger):'
    begin
      kind_train = gets.chomp.to_s
      raise 'Kind should be 1 or 2' if kind_train !~ /[1-2]{1}/
      kind_train
    rescue RuntimeError => e
      puts e.message.to_s
      retry
    end
  end

  def create_particular_train(kind_train, number_train)
    train_list = { '1' => CargoTrain, '2' => PassengerTrain }
    trains << train_list[kind_train].new(number_train)

    puts "#{train.class} (no. #{train.number}) has created"
  end

  def create_train
    kind_train = choose_kind_of_train
    begin
      puts 'Number of train:'
      number_train = gets.chomp.to_s
      create_particular_train(kind_train, number_train)
    rescue RuntimeError => e
      puts "#{e.message} Try again."
      retry
    end
  end

  def create_van
    puts 'Kind of van (1-Cargo; 2-Passenger):'
    kind_van = gets.chomp.to_i
    puts 'Number of van:'
    number_van = gets.chomp.to_i
    puts kind_van == 1 ? 'Capacity:' : 'Amount of seats:'
    value = gets.chomp.to_i
    van_list = { 1 => CargoVan, 2 => PassengerTrain }
    vans << van_list[kind_van].new(number_van, value)
  end

  def add_van_to_train
    puts 'Choose a van: '
    vans.each_with_index do |item, index|
      puts " #{index} - #{item.number}, #{item.kind}"
    end
    index_van = gets.chomp.to_i
    puts 'Choose a train: '
    trains.each_with_index do |item, index|
      puts " #{index} - #{item.number}, #{item.kind}"
    end
    trains[gets.chomp.to_i].add_van vans[index_van]
  end

  def delete_van_from_train
    puts 'Choose a train: '
    trains.each_with_index do |item, index|
      puts " #{index} - #{item.number}, #{item.kind}"
    end
    index_train = gets.chomp.to_i

    train = trains[index_train]
    puts "Train - number: #{train.number}, kind: #{train.kind}"

    train.vans.each_with_index do |item, index|
      puts " #{index} - #{item.number}, #{item.kind}"
    end
    puts 'Choose van for deleting: '
    index_van = gets.chomp.to_i

    train.delete_van(train.vans[index_van])
  end

  def change_station
    puts 'Choose a station: '
    stations.each_with_index { |item, index| puts " #{index} - #{item.name}" }
    index_station = gets.chomp.to_i

    puts 'Choose a train: '
    trains.each_with_index do |item, index|
      puts " #{index} - #{item.number}, #{item.kind}"
    end
    index_train = gets.chomp.to_i

    trains[index_train].station = stations[index_station]
  end

  def list_of_station
    puts 'List of stations:'
    stations.each { |item| puts " - #{item.name}" }
  end

  def list_of_train
    puts 'Choose a station: '
    stations.each_with_index { |item, index| puts " #{index} - #{item.name}" }
    index_station = gets.chomp.to_i

    station = stations[index_station]
    puts "Station - #{station.name}"

    trains.each do |item|
      puts " - #{item.number}, #{item.kind}" if item.station == station
    end
  end
end
