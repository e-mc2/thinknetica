module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :checks

    def validate(attr, kind, *params)
      @checks ||= {}
      @checks[attr] ||= []
      @checks[attr] << { kind: kind, params: params }
    end
  end

  module InstanceMethods
    def valide?
      validate!
    rescue
      false
    end

    private

    VALIDATIONS = {
      presence: proc do |name, value|
        raise "'#{name}' shouldn't be nil or empty!" if value.nil? || value == ''
      end,
      format: proc do |name, value, params|
        raise "'#{name}' not equal to format '#{params[1]}'" if value !~ params[0]
      end,
      type: proc do |name, value, params|
        raise "'#{name}'.class should be '#{params.first}'" if value.class != params.first
      end,
      equal: proc do |name, value, params|
        raise "'#{attr}' should be equal '#{params.first}'" if value != params.first
      end
    }

    def validate!
      self.class.checks.each do |key, checks|
        value = instance_variable_get("@#{key}".to_sym)
        checks.each do |check| 
          VALIDATIONS[check[:kind]].call(key, value, check[:params])
        end
      end
      true
    end
  end
end

class Test
  extend Accessor
  include Validation

  attr_accessor_with_history :name, :number

  validate :name, :type, String
  validate :number, :type, String
  validate :name, :presence
  validate :number, :format, /^[a-z0-9]{3}\-*[a-z0-9]{2}$/i, "XXX-XX or XXXXX"

  def initialize(name, number)
    @name = name
    @number = number
    validate!
  end
end
