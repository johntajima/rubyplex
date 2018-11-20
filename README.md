# Rubyplex - Simple Ruby gem for Plex API

Rubyplex is a super basic gem for accessing the Plex API on your local Plex Media Server. 

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

  movie_section = server.section('Movies') # or server.section(1)

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



## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## TODO

* Need some tests
