# Plex

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/rubyplex`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rubyplex'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rubyplex

## Usage

Require the gem:

```
require 'rubyplex'
```

Add configuration:

```
  Plex.configure do |config|
    config[:host]  = "<ip address>"
    config[:port]  = # port number or 32400 by default
    config[:token] = "your-api-token"
  end
```

Then use as needed:

```
  server = Plex.server

  sections = server.sections

  movie_section = server.section('Movies')

  movies = movie_section.all
```

You can options when filtering

```
section.all(sort: 'year')                     # sort results by release year
section.all(sort: 'year', direction: 'dsec')  # sort results by release year descending
section.all(page: 5, per_page: 100)           # lists page 5 (results 500-599)
```

Other filtering options standard to Plex exists

```
section.by_year(1999)
section.by_decade(2000)
section.unwatched
section.newest
section.recently_added
section.recently_viewed
```

A special filter method exists:

```
section.updated_since(1.day.ago)    # lists movies that were updatedAt > time
```



## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/rubyplex.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## TODO

- tests, tests, tests