class Van
  include Validation
  include Manufacturer
  include InstanceCounter
  attr_reader :number, :kind

  validate :number, :presence
  validate :number, :type, Fixnum
  
  def initialize(number)
    @number = number
    @kind = kind!
    validate!
    register_instance
  end

  protected

  attr_writer :kind, :seats

  def kind!
    'Base'
  end
end
