require "power_struct"

RSpec.describe PowerStruct do
  describe "an empty power struct" do
    let(:struct) { described_class.new() }

    it "can be instantiated" do
      struct.new
    end
  end

  describe "a power struct with multiple attributes" do
    let(:struct) { described_class.new(:foo, :bar) }

    it "refuses to initialize with simple arguments" do
      expect {
        struct.new(1, 2)
      }.to raise_exception(described_class::ArgumentError)
    end

    it "initializes with named arguments" do
      foo = 1
      bar = 2

      instance = struct.new(foo: foo, bar: bar)

      expect(instance.foo).to be(foo)
      expect(instance.bar).to be(bar)
    end

    it "initializes with different order of arguments" do
      foo = 1
      bar = 2

      instance = struct.new(bar: bar, foo: foo)

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
      }.to raise_exception(described_class::ArgumentError)
    end

    it "refuses to initialize with excess arguments" do
      expect {
        struct.new(foo: nil, bar: nil, baz: nil)
      }.to raise_exception(described_class::ArgumentError)
    end
  end

  describe "a set of two power structs" do
    let(:struct1) { described_class.new(:foo) }
    let(:struct2) { described_class.new(:bar) }

    it "does not have interference" do
      expect(struct1.new(foo: nil)).to respond_to(:foo)
      expect(struct2.new(bar: nil)).not_to respond_to(:foo)
    end
  end

  describe "a power struct with default initialization arguments" do
    let(:struct) { described_class.new(:foo, bar: :bar) }

    it "defaults" do
      expect(struct.new(foo: :foo).bar).to be(:bar)
      #raise
    end

    it "allows defaults to be overwritten on construction" do
      expect(
        struct.new(foo: :foo, bar: :not_bar).bar
      ).to be(:not_bar)
    end
  end

  describe "extensibility as a class" do
    let(:struct) {
      described_class.new(:foo) do
        def extension
          :extension
        end
      end
    }

    it "is effectively available" do
      expect(struct.new(foo: nil).extension).to be(:extension)
    end
  end
end

