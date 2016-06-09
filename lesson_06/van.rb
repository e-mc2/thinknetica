class Van
  include Manufacturer
  include InstanceCounter
  attr_reader :number, :kind
 
  @@instances = 0

  def initialize(number)
    @number = number
    @kind = kind!
    register_instance
    valid?
  end
  
  def valid?
    raise "Number shouldn't be nil!" if number.nil?
    raise "Number should be consist of digits" if number.class != Fixnum
    raise "Number should be 5 symbols at least" if number.length < 5
    true
  end

  def kind
    'Base'
  end

  protected

  attr_writer :kind

  def kind!
    self.kind = kind
  end
end

class PassengerVan < Van
  def kind
    "Passenger"
  end
end

class CargoVan < Van
  def kind
    "Cargo"
  end
end
