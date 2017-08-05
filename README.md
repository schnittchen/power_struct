# PowerStruct

Simple `Struct` replacement with mandatory keyword arguments.

Reasons to use `PowerStruct`:

* Argument order no longer matters
* Initialization arguments are mandatory by default
* Cheesy name


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'power_struct'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install power_struct

## Usage

```ruby
require "power_struct"

MyStruct = PowerStruct.new(:attr1, attr2: :attr2_default)

my_struct = MyStruct.new(attr1: "attr1_value")
my_struct.attr1 # => "attr1_value"
my_struct.attr2 # => :attr2_default
my_struct.attr2 = 1
my_struct.attr2 # => 1

my_struct = MyStruct.new # => raises exception, attr1 is mandatory
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/schnittchen/power_struct.

