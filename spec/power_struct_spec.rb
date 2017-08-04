require "power_struct"

RSpec.describe PowerStruct do
  describe "an empty power struct" do
    let(:struct) { described_class.new() }

    it "can be instantiated" do
      struct.new
    end
  end
end

