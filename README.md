# Uniqueness

[![Code Climate](https://codeclimate.com/github/owahab/uniqueness/badges/gpa.svg)](https://codeclimate.com/github/owahab/uniqueness)
[![Build Status](https://travis-ci.org/owahab/uniqueness.svg?branch=master)](https://travis-ci.org/owahab/uniqueness)
[![Coverage Status](https://coveralls.io/repos/github/owahab/uniqueness/badge.svg?branch=master)](https://coveralls.io/github/owahab/uniqueness?branch=master)
[![Inline docs](http://inch-ci.org/github/owahab/uniqueness.svg?branch=master)](http://inch-ci.org/github/owahab/uniqueness)
[![security](https://hakiri.io/github/owahab/uniqueness/master.svg)](https://hakiri.io/github/owahab/uniqueness/master)

Rails recently introduced `has_secure_token` but it's very primitive.
Meet the competition.

[Code Documentation](http://www.rubydoc.info/github/owahab/uniqueness)

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

`:type` type of string, defaults to __:hash__ and can be one of: `:human`, `:hash`

`:blacklist` characters to exclude when generating the random string, defaults to __[]__

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Please see CONTRIBUTING.md for details.

## Credits
recognition was originally written by Omar Abdel-Wahab.
