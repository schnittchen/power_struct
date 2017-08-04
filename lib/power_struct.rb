require "power_struct/version"

module PowerStruct
  def self.new(*attributes, &block)
    Class.new(Base) do
      class << self
        attr_reader :attributes
      end
      @attributes = attributes

      def initialize(**arguments)
        raise ArgumentError if arguments.keys != self.class.attributes

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
