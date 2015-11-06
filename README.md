# Ciika

[![Build Status](https://secure.travis-ci.org/inutano/ciika.png)](http://travis-ci.org/inutano/ciika)

Ciika is utility tool to handle metadata of public NGSeq repository.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ciika'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ciika

## Usage

Parse Sequence Read Archive metadata xml

```ruby
xml = "/path/to/DRA000001.experiment.xml"
data = Ciika::SRA::Experiment.new(xml).parse
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/ciika.

