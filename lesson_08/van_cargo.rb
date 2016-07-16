require_relative 'van'

class CargoVan < Van
  attr_reader :capacity, :filled_capacity

  def initialize(number, capacity)
    super(number)
    @capacity = capacity
  end

  def fill!(capacity)
    more = filled_capacity + capacity > self.capacity
    raise "The van haven't an capacity enough!" if more
    filled_capacity += capacity
  end

  def filled_part
    filled_capacity
  end

  def nofilled_part
    capacity - filled_capacity
  end

  protected

  def kind!
    'Cargo'
  end
end
