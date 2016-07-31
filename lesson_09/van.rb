class Van
  include Validation
  include Manufacturer
  include InstanceCounter
  attr_reader :number, :kind

  def initialize(number)
    validate! number, :presence
    validate! number, :type, Fixnum
    @number = number
    @kind = kind!
    register_instance
  end

  protected

  attr_writer :kind, :seats

  def kind!
    'Base'
  end
end
