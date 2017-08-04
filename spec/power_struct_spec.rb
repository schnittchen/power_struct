require "power_struct"

RSpec.describe PowerStruct do
  describe "an empty power struct" do
    let(:struct) { described_class.new() }

    it "can be instantiated, or instructs to pass arguments" do
      pending
      struct.new
    end
  end

  describe "a power struct with multiple attributes" do
    let(:struct) { described_class.new(:foo, :bar) }

    it "initializes with named arguments" do
      foo = 1
      bar = 2

      instance = struct.new(foo: foo, bar: bar)

      expect(instance.foo).to be(foo)
      expect(instance.bar).to be(bar)
    end

    it "has accessors" do
      instance = struct.new(foo: nil, bar: nil)
      instance.foo = :foo
      expect(instance.foo).to be(:foo)
    end

    it "refuses to initialize with too few arguments" do
      expect {
        struct.new(foo: nil)
      }.to raise_exception(ArgumentError)
    end
  end
end

