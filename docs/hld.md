# High Level Design 

Plex::
  
  Server
    has_many :libraries
      - title
      - when it was scanned
      - location of paths

  Library
    - total count of entries
    - title
    - last_updated
    - scannedAt

  MovieLibrary < Library
  ShowLibrary < Library

  MovieLibrary
    - total_count (entries)
    has_many :movies

    Movie
      - title
      - year
      - release_date
      - genre
      - director
      - roles

      has_many :medias

    Media
      has_many :parts

  ShowLibrary
    has_many :shows

    Show
      has_many :episodes

    Episode
      has_many :medias

    Media
      has_many :parts



### API

Plex

  Plex.server   #=> returns server model
  Plex.config   #=> returns or sets config

Server

  server.libraries        #=> return all libaries on plex
  server.library_by_path  #=> return library based on dl path
  server.query            #=> execute query and returns hash of response

Library
- either a Movie library, Show library ?

  .total_count
  .all(options = {})      #=> load entries
  .newest(options = {})
  .recent(options = {})
  .updated_since(time, options = {})
  .recently_added(options = {})
  .recently_viewed(options = {})
  .by_year(year, options = {})
  .by_decade(decade, options = {})
  .find_by_filename(filename)   # => find movie/show by filename(full path), returns movie/show entry
  .search(filename?/title)
  .type           # movie/show

Movie
  .key
  .attributes
  .title
  .year
  .imdb
  .rating
  .release_date
  .duration
  .added_at
  .medias    #=> [media, media, media,...]

Show
  .key
  .attributes
  .title
  .year
  .imdb
  .tvdb
  .release_date
  .added_at
  .key
  .seasons_count
  .episodes_count
  .episodes => [episode, ....]

Episode
  .show => link to show
  .episode
  .season
  .medias    #=> [media, media, media,...]

Media
  .filename  => full filename
  .path
  .audio_codec
  .audio_channels
  .video_codec
  .resolution
  .file_size
  .file_id
  .file_duration