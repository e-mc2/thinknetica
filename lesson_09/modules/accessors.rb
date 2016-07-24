module Accessor
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      var_name_history = "@#{name}_history".to_sym

      define_method(name) { instance_variable_get(var_name) }

      define_method("#{name}=".to_sym) do |value|
        instance_variable_set(var_name, value)
        history = instance_variable_get(var_name_history)
        history.nil? ? history = [value] : history << value
        instance_variable_set(var_name_history, history)
      end
    end

    define_method("#{name}_history") { instance_variable_get(var_name_history) }
  end
end

class Testing
  extend Accessor

  attr_accessor_with_history :abc, :kwarg

end
