class Van
  attr_reader :number, :kind

  def initialize(number)
    @number = number
    @kind = kind!
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
