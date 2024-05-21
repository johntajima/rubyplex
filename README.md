# Plex - Simple Ruby gem for Plex API

Plex is a super basic gem for accessing the Plex API on your local Plex Media Server. 

*** V2 is a overall rewrite, although the basic methods and attributes are mostly the same, underneath
was rewritten. Please note where many of the attributes and methods have changed. ***


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

```
require 'rubyplex'

config = {
  host: '192.168.2.5',
  port: 32400,
  token: 'some-plex-token'
}

server = Plex.server(config) # OR Plex::Server.new(config)

```

Or set a ~/.rubyplex.yml file 

```
PLEX_HOST: '192.168.2.5'
PLEX_PORT: 32400
PLEX_TOKEN: 'some-valid-token'
```

``` 
require 'rubyplex'

server = Plex.server  # uses config values from ~/.rubyplex.yml
```

Use ```https://x.x.x.x``` to specify https, otherwise defaults to http when settting just an IP address.



Then use as needed:

```
  server = Plex.server(config)

  libraries = server.libraries

  movie_library = server.library('Movies') # or server.library(1)

  movies = movie_library.all  # array of all movies in the library
```

### Library

```
library = server.libraries.all.first

Listing entries

movies = library.all                            # list of all movies
movies = library.unwatched                      # list of unwatched movies
movies = library.newest                         # list of newest movies
movies = library.recently_added                 # list of recently added movies

  options:
    page        # page of results to return
    per_page    # number of entries per page
    sort        # coming soon
    direction   # coming soon

  eg: library.all(options: {page: 1, per_page: 10})
```

A special filter method exists:

```
library.updated_since(1.day.ago)    # lists movies that were updatedAt > time
```

#### Searching

Find movie by filename
``` 
  movie = library.find_by_filename('name-of-file.mp4')
  movie = library.find_by_filename('movie-name.mp4', full_path: true)
```
If ```full_path``` is true, then filename must include the full root path.
If ```full_path``` is false (by default), you can just use the filename

Find movie by title

```
movie = library.find_by_title('Star Wars')
```

### Movie

Movie is a plex movie.

```
.to_hash              # => returns original plex hash of attributes
.to_json              # => json of original hash
.medias               # => array of Media objects
.<param>              # => attribute value. 
    If attribute name is lowercase, param is lowercase
      eg: 'title' => movie.title
    If attribute is camelCase, param is underscore  
      eg: 'updatedAt' => movie.updated_at
    If attribute is Capitalized (usually an association), param is lowercase 
      eg: 'Genre' => movie.genre # => ['action', 'adventure']

.load_details!      # reload Movie model with extended params (including Stream details)
.find_by_filename(filename)   # returns Media model which has the file 
.imdb               # IMDB number ttxxxxxx
.tvdb
.id                 # same as "ratingKey" attribute
.release_date       # same as "originallyAvailableAt"
.files              # array of all files associated with movie
```

### Show & Episode model

Show is a plex TV show. Show is made up of an array of episodes. An Episode has many Medias.

```
show = library.all.first
show.episodes  # => array of episode models
episode.medias # => array of medias

.to_hash              # => returns original plex hash of attributes
.to_json              # => json of original hash
.medias               # => array of Media objects
.<param>              # => attribute value. 
    If attribute name is lowercase, param is lowercase
      eg: 'title' => movie.title
    If attribute is camelCase, param is underscore  
      eg: 'updatedAt' => movie.updated_at
    If attribute is Capitalized (usually an association), param is lowercase 
      eg: 'Genre' => movie.genre # => ['action', 'adventure']

.seasons_count        # total # of seasons
.episodes_count       # total # of episodes
.season(X)            # returns array of all episodes for given season
.episode(season, x)   # returns specific episode # of season
.episodes             # array of all episodes
.tvdb                 # TVDB id (if exists)
.files                # array of all files associated with TV Show
.find_by_filename(filename)     # returns the episode that has the given file
```

```
episode = show.episodes.first
.to_hash              # => returns original plex hash of attributes
.to_json              # => json of original hash
.medias               # => array of Media objects
.<param>              # => attribute value. 
    If attribute name is lowercase, param is lowercase
      eg: 'title' => movie.title
    If attribute is camelCase, param is underscore  
      eg: 'updatedAt' => movie.updated_at
    If attribute is Capitalized (usually an association), param is lowercase 
      eg: 'Genre' => movie.genre # => ['action', 'adventure']

.season               # which season # of the episode
.episode              # which episode # this is
.load_details!        # load all episode details, including stream info
.medias               # array of Media objects
.files                # array of filenames
.media_by_filename(filename)    # finds media by filename
.label                # returns "S01E01" for given season/episode
```

### Media

Media has many parts. 

```
media = movie.medias.first

.to_hash              # => returns original plex hash of attributes
.to_json              # => json of original hash
.<param>              # => attribute value. 
    If attribute name is lowercase, param is lowercase
      eg: 'title' => movie.title
    If attribute is camelCase, param is underscore  
      eg: 'updatedAt' => movie.updated_at
    If attribute is Capitalized (usually an association), param is lowercase 
      eg: 'Genre' => movie.genre # => ['action', 'adventure']

.parts                # array of Part models
.has_file?(filename)  # returns true if file w/ filename exists
```




## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## TODO

* Add back some of the search methods from the original version

