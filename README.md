# Plex - Simple Ruby gem for Plex API

Plex is a super basic gem for accessing the Plex API on your local Plex Media Server. 

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

  libraries = server.libraries

  movie_library = server.library('Movies') # or server.library(1)

  movies = movie_library.all  # array of all movies in the library
```

You can options when filtering

```
library.all(sort: 'year')                     # sort results by release year
library.all(sort: 'year', direction: 'dsec')  # sort results by release year descending
library.all(page: 5, per_page: 100)           # lists page 5 (results 500-599)
```

Other filtering options standard to Plex exists

```
library.by_year(1999)
library.by_decade(2000)
library.unwatched
library.newest
library.recently_added
library.recently_viewed
```

A special filter method exists:

```
library.updated_since(1.day.ago)    # lists movies that were updatedAt > time
```

You can search a library for a movie or show(episode) by the filename it is stored as.

```
library.find_by_filename(full_or_partial_filename)  # => returns media model associated 

eg: library.find_by_filename("Star Wars (1977).mp4")
```

The returning Media model as a .parent method which will return the Movie or Episode (if a show)
associated to the file. Episode has a .show method to return the actual Show model.

### Movie

A movie library will return array of Movie models. A movie model has a number of attributes:

```
.title        title of the movie
.year         year of movie release
.rating       imdb rating
.id           the plex Metadata id (key)
.type         movie / show 
.duration     duration in seconds
.release_date Time object
.added_at     DateTime it was added to Plex db
.updated_at   DateTime it was last updated
.genres       array of genre tag words
.directors    array of directors
.roles        array of actors
.countries    array of country names
.imdb         the imdb id if plex agent was imdb
.tmdb         the tmdb id if agent was tmdb
.medias       An array of media models associated to Movie
```

```
.to_hash => returns a hash of all attributes, plus a :medias => [all medias Models]
```

```
.by_file() => returns media associated to Movie if the filename matches
```

All models (Movie, Show, Episode, Media) include a .hash method which returns the original
hash from Plex, where keys are in string format, in case you need to access the original
Plex hash attributes.



### Show

A Show is similiar to a movie, but it has many episodes. The Episode model contains the array
of Media models. Use the .attributes method to see the various attributes.


Other methods:

```
.episodes                returns list of all Episodes
.episode(season, index)  returns a given episode
.season(index)           returns array of all episodes for the given season
.by_file(filename)       returns Media model associated to episode with the given file
.attributes              hash of all attributes
.to_hash                 returns hash of all attributes, including :medias array
```

### Episode

Episode is associated to a given show. There is one Episode model for every episode of every
season for a given show.

Episode has an index number and a season number.

Episode has a medias array of all files associated to the given episode.


```
.attributes              hash of all attributes
.to_hash                 returns hash of all attributes, including :medias array
.by_file(filename)       returns Media model associated to episode with the given file
.show                    returns Show model associated to Episode
```

### Medias

A media model is associated to Movie or TV Episode and associates the files associated
to the given show/movie.

```
.parent             returns the Movie or Episode (for show) model 
.has_file?(file)    returns true if file exists for the given media
```


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## TODO

* Need some tests
