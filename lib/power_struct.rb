require "power_struct/version"

module PowerStruct
  def self.new(*attributes)
    Class.new(Base) do
      class << self
        attr_reader :attributes
      end
      @attributes = attributes

      def initialize(*arguments)
        raise ArgumentError if arguments.first.keys != self.class.attributes

        arguments.first.each do |attribute, value|
          self.public_send("#{attribute}=", value)
        end
      end

      attr_accessor(*attributes)
    end
  end

  class Base
  end
end
