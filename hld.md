# HLD

Api

Plex.server
- has many sections

## server

server.sections()         # => array of sesctions
server.section(id | name) # => returns section model


# Models

Server
- Section (movies/shows/photos/...)
  - Video (Movies)
    - Media
      - Part
        - Stream
      - Genre
      - Director
      - Writer
      - Country
      - Collection
      - Role (actors)


## sections

section.all
section.by_first_character()
section.by_folder()
section.newest()
section.recently_added

section
- has many: videos

## containers


container.Video
Video












# photo libraries

## get the photos library 

GET http://192.168.2.10:32400/library/sections/1  

{"MediaContainer"=>
  {"size"=>"19",
   "allowSync"=>"0",
   "art"=>"/:/resources/movie-fanart.jpg",
   "content"=>"secondary",
   "identifier"=>"com.plexapp.plugins.library",
   "librarySectionID"=>"1",
   "mediaTagPrefix"=>"/system/bundle/media/flags/",
   "mediaTagVersion"=>"1537529855",
   "thumb"=>"/:/resources/movie.png",
   "title1"=>"Movies",
   "viewGroup"=>"secondary",
   "viewMode"=>"65592",
   "Directory"=>
    [{"key"=>"all", "title"=>"All Movies"},
     {"key"=>"unwatched", "title"=>"Unplayed"},
     {"key"=>"newest", "title"=>"Recently Released"},
     {"key"=>"recentlyAdded", "title"=>"Recently Added"},
     {"key"=>"recentlyViewed", "title"=>"Recently Viewed"},
     {"key"=>"onDeck", "title"=>"On Deck"},
     {"secondary"=>"1", "key"=>"collection", "title"=>"By Collection"},
     {"secondary"=>"1", "key"=>"genre", "title"=>"By Genre"},
     {"secondary"=>"1", "key"=>"year", "title"=>"By Year"},
     {"secondary"=>"1", "key"=>"decade", "title"=>"By Decade"},
     {"secondary"=>"1", "key"=>"director", "title"=>"By Director"},
     {"secondary"=>"1", "key"=>"actor", "title"=>"By Starring Actor"},
     {"secondary"=>"1", "key"=>"country", "title"=>"By Country"},
     {"secondary"=>"1", "key"=>"contentRating", "title"=>"By Content Rating"},
     {"secondary"=>"1", "key"=>"rating", "title"=>"By Rating"},
     {"secondary"=>"1", "key"=>"resolution", "title"=>"By Resolution"},
     {"secondary"=>"1", "key"=>"firstCharacter", "title"=>"By First Letter"},
     {"key"=>"folder", "title"=>"By Folder"},
     {"prompt"=>"Search Movies",
      "search"=>"1",
      "key"=>"search?type=1",
      "title"=>"Search..."}]}}

## get all albums in library X

GET http://192.168.2.10:32400/library/sections/1/all

{"MediaContainer"=>
  {"size"=>"1",
   "allowSync"=>"1",
   "art"=>"/:/resources/photo-fanart.jpg",
   "identifier"=>"com.plexapp.plugins.library",
   "librarySectionID"=>"4",
   "librarySectionTitle"=>"Photos",
   "librarySectionUUID"=>"e69d91d7-766e-4ff0-879f-ad08f9137a86",
   "mediaTagPrefix"=>"/system/bundle/media/flags/",
   "mediaTagVersion"=>"1537529855",
   "nocache"=>"1",
   "thumb"=>"/:/resources/photo.png",
   "title1"=>"Photos",
   "title2"=>"All Photos",
   "viewGroup"=>"photo",
   "viewMode"=>"131633",
   "Directory"=>
    {"ratingKey"=>"17265",
     "key"=>"/library/metadata/17265/children",
     "type"=>"photo",
     "title"=>"Eufimia_sm",
     "summary"=>"",
     "index"=>"1",
     "composite"=>"/library/metadata/17265/composite/1536259482",
     "thumb"=>"/library/metadata/17265/thumb/1536259482",
     "art"=>"/library/metadata/17265/art/1536259482",
     "addedAt"=>"1510068699",
     "updatedAt"=>"1536259482",
     "__content__"=>"\n"}}}

# get photos in library
GET http://192.168.2.10:32400/library/metadata/17265/children

{"MediaContainer"=>
  {"size"=>"182",
   "allowSync"=>"1",
   "art"=>"/library/metadata/17265/art/1536259482",
   "identifier"=>"com.plexapp.plugins.library",
   "key"=>"17265",
   "librarySectionID"=>"4",
   "librarySectionTitle"=>"Photos",
   "librarySectionUUID"=>"e69d91d7-766e-4ff0-879f-ad08f9137a86",
   "mediaTagPrefix"=>"/system/bundle/media/flags/",
   "mediaTagVersion"=>"1537529855",
   "nocache"=>"1",
   "parentIndex"=>"1",
   "parentTitle"=>"Eufimia_sm",
   "thumb"=>"/library/metadata/17265/thumb/1536259482",
   "title1"=>"Photos",
   "title2"=>"Eufimia_sm",
   "viewGroup"=>"photo",
   "viewMode"=>"131633",
   "Photo"=>
    [{"ratingKey"=>"17321",
      "key"=>"/library/metadata/17321",
      "parentRatingKey"=>"17265",
      "type"=>"photo",
      "title"=>"20051216_205223",
      "parentKey"=>"/library/metadata/17265",
      "summary"=>"",
      "index"=>"1",
      "year"=>"2005",
      "thumb"=>"/library/metadata/17321/thumb/1510069150",
      "originallyAvailableAt"=>"2005-12-16",
      "addedAt"=>"1510068805",
      "updatedAt"=>"1510069150",
      "createdAtAccuracy"=>"local",
      "createdAtTZOffset"=>"-18000",
      "Media"=>
       {"id"=>"38431",
        "width"=>"1600",
        "height"=>"1064",
        "aspectRatio"=>"1.66",
        "container"=>"jpeg",
        "Part"=>
         {"id"=>"38450",
          "key"=>"/library/parts/38450/1510068527/file.jpg",
          "file"=>"/volume5/Photos/Albums/Eufimia_sm/20051216_205223.jpg",
          "size"=>"739444",
          "container"=>"jpeg"}
        }
      },
      ...
      ...
    ]
  }
}


All shows of a given season

/library/metadata/34921/children

{"MediaContainer"=>
  {"size"=>"10",
   "totalSize"=>"13",
   "allowSync"=>"1",
   "art"=>"/library/metadata/34858/art/1540930562",
   "banner"=>"/library/metadata/34858/banner/1540930562",
   "grandparentContentRating"=>"TV-14",
   "grandparentRatingKey"=>"34858",
   "grandparentStudio"=>"SciFi",
   "grandparentTheme"=>"/library/metadata/34858/theme/1540930562",
   "grandparentThumb"=>"/library/metadata/34858/thumb/1540930562",
   "grandparentTitle"=>"Battlestar Galactica (2003)",
   "identifier"=>"com.plexapp.plugins.library",
   "key"=>"34921",
   "librarySectionID"=>"2",
   "librarySectionTitle"=>"TV Shows",
   "librarySectionUUID"=>"8c4d0168-6ea2-45e4-a4b1-6a9a8280f218",
   "mediaTagPrefix"=>"/system/bundle/media/flags/",
   "mediaTagVersion"=>"1537529855",
   "nocache"=>"1",
   "offset"=>"0",
   "parentIndex"=>"1",
   "parentTitle"=>"",
   "theme"=>"/library/metadata/34858/theme/1540930562",
   "thumb"=>"/library/metadata/34921/thumb/1540930562",
   "title1"=>"Battlestar Galactica (2003)",
   "title2"=>"Season 1",
   "viewGroup"=>"episode",
   "viewMode"=>"65592",
   "Video"=>
    [{"ratingKey"=>"34922",
      "key"=>"/library/metadata/34922",
      "parentRatingKey"=>"34921",
      "grandparentRatingKey"=>"34858",
      "type"=>"episode",
      "title"=>"33",
      "grandparentKey"=>"/library/metadata/34858",
      "parentKey"=>"/library/metadata/34921",
      "grandparentTitle"=>"Battlestar Galactica (2003)",
      "parentTitle"=>"Season 1",
      "contentRating"=>"TV-14",
      "summary"=>
       "In the wake of the Cylon sneak attack, the ragtag fleet of human survivors is forced to play a deadly game of cat-and-mouse with their pursuers. Every 33 minutes, they make a jump to a new location. And every 33 minutes, the Cylons manage to find them. The pilots are on the brink of exhaustion, relying on artificial stimulants to keep fighting, and the civilians are beginning to doubt the leadership of Commander Adama and President Roslin.\r\n",
      "index"=>"1",
      "parentIndex"=>"1",
      "rating"=>"7.9",
      "viewCount"=>"1",
      "lastViewedAt"=>"1513119796",
      "year"=>"2005",
      "thumb"=>"/library/metadata/34922/thumb/1540930556",
      "art"=>"/library/metadata/34858/art/1540930562",
      "parentThumb"=>"/library/metadata/34921/thumb/1540930562",
      "grandparentThumb"=>"/library/metadata/34858/thumb/1540930562",
      "grandparentArt"=>"/library/metadata/34858/art/1540930562",
      "grandparentTheme"=>"/library/metadata/34858/theme/1540930562",
      "duration"=>"2683765",
      "originallyAvailableAt"=>"2005-01-14",
      "addedAt"=>"1539001388",
      "updatedAt"=>"1540930556",
      "chapterSource"=>"media",
      "Media"=>
       {"videoResolution"=>"720",
        "id"=>"77214",
        "duration"=>"2683765",
        "bitrate"=>"1378",
        "width"=>"1280",
        "height"=>"720",
        "aspectRatio"=>"1.78",
        "audioChannels"=>"2",
        "audioCodec"=>"aac",
        "videoCodec"=>"h264",
        "container"=>"mkv",
        "videoFrameRate"=>"24p",
        "audioProfile"=>"lc",
        "videoProfile"=>"high",
        "Part"=>
         {"id"=>"77751",
          "key"=>"/library/parts/77751/1446695752/file.mkv",
          "duration"=>"2683765",
          "file"=>
           "/volume4/Media2/TV/Battlestar Galactica/Battlestar Galactica S01/Battlestar Galactica S01E01 [720p].mkv",
          "size"=>"462381169",
          "audioProfile"=>"lc",
          "container"=>"mkv",
          "videoProfile"=>"high"}},
      "Director"=>{"tag"=>"Allan Kroeker"},
      "Writer"=>{"tag"=>"Ronald D. Moore"}},
  ...
  ...
