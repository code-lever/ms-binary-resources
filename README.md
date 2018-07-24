# Ms::BinaryResources [![Build Status](https://travis-ci.org/code-lever/ms-binary-resources.png)](https://travis-ci.org/code-lever/ms-binary-resources) [![Code Climate](https://codeclimate.com/github/code-lever/ms-binary-resources.png)](https://codeclimate.com/github/code-lever/ms-binary-resources)

A way to read Microsoft's binary resource files in Ruby.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ms-binary-resources'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install ms-binary-resources
```

## Usage

```ruby
reader = Ms::BinaryResources::Reader.new('/path/to/File.resources')
reader.keys
=> ['key1', 'key2', ...]
reader.key? 'key1'
=> true
reader.key? 'keyxx'
=> false
reader['key1']
=> 'some value'
reader.type_of 'key2'
=> :int32
reader['key2']
=> 8675309
```

## Caveats

Currently only string, uint and int value types are supported.  Pull requests with additional types are great, include tests!

## Thanks

This is largely cribbed off of the [Mono Project's](https://github.com/mono/mono) class library implementation of ResourceReader and friends.

## Contributing

1. Fork it ( https://github.com/code-lever/ms-binary-resources/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
