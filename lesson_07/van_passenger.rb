require_relative 'van'

class PassengerVan < Van
  attr_reader :seats

  def initialize(number, seats)
    super(number)
    @seats = Array.new(seats, true)
  end

  def take_the_seat!
    i = self.seats.index(true)
    raise "this van is full!" if !i
    self.seats[i] = false
  end

  def count_free_seats
    self.seats.count(true)
  end

  def count_busy_seats
    self.seats.count(false)
  end

  protected

  def kind!
    "Passenger"
  end
end
