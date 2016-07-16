# This mudule helps to count instances of class
module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  # adding getter and setter for class
  module ClassMethods
    attr_accessor :instances
  end

  protected

  # setting up of value
  module InstanceMethods
    def register_instance
      self.class.instances ||= 0
      self.class.instances += 1
    end
  end
end
