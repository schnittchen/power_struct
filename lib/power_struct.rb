require "power_struct/version"

module PowerStruct
  def self.new(*attributes)
    Class.new(Base) do
      def initialize(*arguments)
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
