module InstanceCounter
  
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def instances
      self.class.class_variable_get :@@instances
    end 
  end

  protected
  module InstanceMethods
    def register_instance
      value = self.class.class_variable_get :@@instances
      value += 1
      self.class.class_variable_set :@@instances, value
    end
  end
end
