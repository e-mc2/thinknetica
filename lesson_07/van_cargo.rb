require_relative 'van'

class CargoVan < Van
  attr_reader :capacity

  def initialize (number, capacity)
    super(number)
    @capacity = [0,capacity]
  end

  def fill!(capacity)
    raise "The van haven't an capacity enough!" if self.capacity[0]+capacity > self.capacity[1]
    self.capacity[0] += capacity 
  end

  def filled_part
    self.capacity[0]
  end

  def nofilled_part
    self.capacity[1] - self.capacity[0]
  end

  protected

  def kind!
    "Cargo"
  end
end
