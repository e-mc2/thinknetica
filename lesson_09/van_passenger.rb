require_relative 'van'

class PassengerVan < Van
  attr_reader :seats

  def initialize(number, seats)
    super(number)
    @seats = Array.new(seats, true)
  end

  def take_the_seat!
    i = seats.index(true)
    raise 'this van is full!' unless i
    seats[i] = false
  end

  def count_free_seats
    seats.count(true)
  end

  def count_busy_seats
    seats.count(false)
  end

  protected

  def kind!
    'Passenger'
  end
end
