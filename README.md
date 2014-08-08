# Ms::BinaryResources

TODO: Write a gem description

* https://github.com/mosa/Mono-Class-Libraries/blob/master/mcs/class/corlib/System.Resources/ResourceReader.cs

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ms-binary-resources'
```

And then execute:

    $ bundle


Or install it yourself as:

    $ gem install ms-binary-resources

## Usage

```ruby
reader = Ms::BinaryResources::Reader.new('/path/to/file')
reader.keys
=> ['key1', 'key2', ...]
reader.key? 'key1'
=> true
reader.key? 'keyxx'
=> false
reader['key1']
=> 'some value'
```

## Caveats

Currently only string values are supported.

## Contributing

1. Fork it ( https://github.com/code-lever/ms-binary-resources/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
