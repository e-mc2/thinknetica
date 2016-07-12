class Van
  include Manufacturer
  include InstanceCounter
  attr_reader :number, :kind

  def initialize(number)
    @number = number
    @kind = kind!
    register_instance
    validate!
  end

  def valid?
    validate!
  rescue
    false
  end
  
  protected
  attr_writer :kind, :seats
  
  def validate!
    raise "Number shouldn't be nil!" if number.nil?
    raise "Number should be consist of digits" if number.class != Fixnum
    raise "Number should be 5 symbols at least" if number.to_s.size != 5
    true
  end

  def kind!
    "Base"
  end
end
