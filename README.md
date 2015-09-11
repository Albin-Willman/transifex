# Transifex

This is a small gem that allows you to retrive information from a transifex account.

[![Build Status](https://travis-ci.org/Albin-Willman/transifex.png?branch=master)](https://travis-ci.org/Albin-willman/transifex)

[![Code Climate](https://codeclimate.com/github/Albin-trialbee/transifex/badges/gpa.svg)](https://codeclimate.com/github/Albin-trialbee/transifex)

[![Test Coverage](https://codeclimate.com/github/Albin-trialbee/transifex/badges/coverage.svg)](https://codeclimate.com/github/Albin-trialbee/transifex)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'transifex'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install transifex

## Usage

The base of everything is the account class which can be used to retrieve projects as shown below.

```ruby
client   = Transifex::Client.new('email', 'pwd')
projects = client.projects
project  = client.project('project_name')
```

Projects can the be used to find out what languages it is translated to, what resources are avaliable and retrieve those resources.

With a resource you can then retreive the translations for a given language.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/albin-willman/transifex/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
