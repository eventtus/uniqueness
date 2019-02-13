# Uniqueness

[![Gem Version](https://img.shields.io/gem/v/uniqueness.svg)](http://rubygems.org/gems/uniqueness)
[![Build Status](https://travis-ci.org/eventtus/uniqueness.svg?branch=master)](https://travis-ci.org/eventtus/uniqueness)
[![Code Climate](https://codeclimate.com/github/eventtus/uniqueness/badges/gpa.svg)](https://codeclimate.com/github/eventtus/uniqueness)
[![Coverage Status](https://coveralls.io/repos/github/eventtus/uniqueness/badge.svg?branch=master)](https://coveralls.io/github/eventtus/uniqueness?branch=master)
[![Inline docs](http://inch-ci.org/github/eventtus/uniqueness.svg?branch=master)](http://inch-ci.org/github/eventtus/uniqueness)
[![security](https://hakiri.io/github/eventtus/uniqueness/master.svg)](https://hakiri.io/github/eventtus/uniqueness/master)
[![GitHub issues](https://img.shields.io/github/issues/eventtus/uniqueness.svg?maxAge=2592000)](https://github.com/eventtus/uniqueness/issues)
[![Downloads](https://img.shields.io/gem/dtv/uniqueness.svg)](http://rubygems.org/gems/uniqueness)


Rails recently introduced `has_secure_token` but it's very primitive.
Meet the competition.

[Code Documentation](http://www.rubydoc.info/github/eventtus/uniqueness)

## Requirements

Minimum requirements are:

1. Rails __4.0.0+__
2. Ruby __2.0.0+__

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'uniqueness'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install uniqueness

## Usage

Adds random field support to Rails models.

To auto-generate a new random string for field `foo`:

    class Example < ActiveRecord::Base
      has_unique_field :foo
    end

You can customize the generated string by
passing an options hash. The following keys are supported:

`:length` number of characters, defaults to __32__

`:type` type of string, can be one of: `:human`, `:auto`, defaults to __:auto__

Human type generates strings easier to read by excluding ambiguous characters like `1, 5, 8, B, o, O, I, l, s, u`.

`:blacklist` characters to exclude when generating the random string, defaults to __[]__

`:scope` scopes, defines the `ActiveRecord` `scope` applied before calculating the `position` field value. Defaults to __[]__

To generate a unique-random on the fly `Uniqueness.generate` that will produce a random field for you.

You can also pass some options `Uniqueness.generate(type: :human)`.

To regenerate a unique-random value with the same options `example.regenerate_foo`.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Please see CONTRIBUTING.md for details.

## Credits

[![Eventtus](http://assets.eventtus.com/logos/eventtus/standard.png)](http://eventtus.com)

Project is sponsored by [Eventtus](http://eventtus.com).
