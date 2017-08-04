require "power_struct/version"

module PowerStruct
  ArgumentError = Class.new(::ArgumentError)

  def self.new(*mandatory_attributes, **defaults, &block)
    raise ArgumentError, "pass attribute names as symbols" unless \
      mandatory_attributes.all? { |attribute| attribute.is_a?(Symbol) }

    Class.new(Base) do
      class << self
        attr_reader :mandatory_attributes, :attribute_defaults
      end
      @mandatory_attributes = mandatory_attributes
      @attribute_defaults = defaults

      def initialize(*flat_arguments, **arguments)
        raise ArgumentError, "pass parameters as hash arguments" if flat_arguments.any?
        unless (self.class.mandatory_attributes - arguments.keys).empty?
          raise ArgumentError, "missing argument(s) " +
            (self.class.mandatory_attributes - arguments.keys).map(&:inspect).join(", ")
        end
        unless (
            arguments.keys - self.class.mandatory_attributes - self.class.attribute_defaults.keys
          ).none?
          raise ArgumentError, "excess argument(s) " +
            (arguments.keys - self.class.mandatory_attributes - self.class.attribute_defaults.keys)
              .map(&:inspect).join(", ")
        end

        self.class.attribute_defaults.each do |attribute, default|
          self.public_send("#{attribute}=", default)
        end

        arguments.each do |attribute, value|
          self.public_send("#{attribute}=", value)
        end
      end

      attr_accessor(*mandatory_attributes, *defaults.keys)

      class_eval(&block) if block
    end
  end

  class Base
  end
end
