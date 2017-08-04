require "power_struct/version"

module PowerStruct
  ArgumentError = Class.new(::ArgumentError)

  def self.new(*attributes, &block)
    Class.new(Base) do
      class << self
        attr_reader :attributes
      end
      @attributes = attributes

      def initialize(*flat_arguments, **arguments)
        raise ArgumentError, "pass parameters as hash arguments" if flat_arguments.any?
        raise ArgumentError if arguments.keys.sort != self.class.attributes.sort

        arguments.each do |attribute, value|
          self.public_send("#{attribute}=", value)
        end
      end

      attr_accessor(*attributes)

      class_eval(&block) if block
    end
  end

  class Base
  end
end
