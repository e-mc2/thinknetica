class Station
  attr_accessor :trains
  attr_reader :name
  
  @@instances = []
  def self.all
    @@instances
  end
  
  def initialize(name)
    @name = name
    @trains = []
    @@instances << self
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
