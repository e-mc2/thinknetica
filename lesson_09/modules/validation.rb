module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(attr, kind, *param)
      return !attr.nil? && attr != '' if kind == :presence
      return attr =~ param.first if kind == :format
      return attr.class == param.first if kind == :type
      return attr != param.first if kind == :equal
      true
    end
  end

  module InstanceMethods
    def validate!(attr, kind, *param)
      check = self.class.validate(attr, kind, *param)
      if !check
        raise "'#{attr}' shouldn't be nil or empty!" if kind == :presence
        raise "'#{attr}' not equal to format '#{param[1]}'" if kind == :format
        raise "'#{attr}'.class should be '#{param.first}'" if kind == :type
        raise "'#{attr}' should be equal '#{param.first}'" if kind == :equal
      end
    end

    def valide?
      validate!
    rescue
      false
    end
  end
end

class Test
  extend Accessor
  include Validation

  attr_accessor_with_history :name, :number

  def initialize(name, number, van)
    validate! name, :presence
    validate! number, :format, /^[a-z0-9]{3}\-*[a-z0-9]{2}$/i, "XXX-XX or XXXXX"
    validate! van, :type, CargoVan
    @name = name
    @number = number
    @van = van
  end
end
