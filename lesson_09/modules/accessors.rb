module Accessor
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      var_name_history = "@#{name}_history".to_sym

      define_method(name.to_sym) { instance_variable_get(var_name) }
      define_method("#{name}_history".to_sym) { instance_variable_get(var_name_history) }

      define_method("#{name}=".to_sym) do |value|
        instance_variable_set(var_name, value)
        history = instance_variable_get(var_name_history)
        history.nil? ? history = [value] : history << value
        instance_variable_set(var_name_history, history)
      end
    end
  end

  def strong_attr_acessor (name, type)
    var_name = "@#{name}".to_sym

    define_method(name.to_sym) {instance_variable_get(var_name)}
    define_method("#{name}=".to_sym) do |value|
      instance_variable_set(var_name, value) if value.class == type
      raise TypeError.new("You made a type mistake!") if value.class != type
    end
  end
end

class Testing
  extend Accessor
  attr_accessor_with_history :name, :number
  strong_attr_acessor :info, String

  def initialize(name, number)
    @name = name
    @number = number
  end
end
