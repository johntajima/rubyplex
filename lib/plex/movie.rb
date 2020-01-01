module Plex

  class Movie
    include Plex::Base

    attr_reader :medias

    def initialize(hash)
      @attributes = hash.except('Media')
      @medias     = load_medias(hash)
      @attributes.merge!('medias' => @medias)
      add_accessible_methods
    end

    def genres
      @attributes.fetch('Genre').map {|x| x.fetch('tag') }
    end

    def directors
      @attributes.fetch('Director').map {|x| x.fetch('tag') }
    end

    def roles
      @attributes.fetch('Role').map {|x| x.fetch('tag') }
    end

    def countries
      @attributes.fetch('Country').map {|x| x.fetch('tag') }
    end

    def imdb
      load_imdb
      @attributes.fetch('imdb', nil)
    end

    def tmdb
      load_tmdb
      @attributes.fetch('tmdb', nil)
    end


    def find_media(file, full_filename: false)
      medias.find do |media| 
        if full_filename
          media.file == file
        else
          File.basename(media.file) == File.basename(file)        
        end
      end
    end

    private

    def load_medias(orig_hash)
      list = orig_hash.fetch('Media', [])
      list.map {|entry| Plex::Media.new(entry, parent: self) }
    end

    def metadata
      @metadata ||= begin
        movie = Plex.server.query(key)
        movie.fetch("Metadata").first
      end
    end

    def load_imdb
      guid = metadata.fetch('guid')
      return unless guid.match('imdb')
      value = guid.scan(/tt\d{3,}/).first
      @attributes.merge!('imdb' => value)
    end

    def load_tmdb
      guid = metadata.fetch('guid')
      return unless guid.match('themoviedb')
      value = guid.scan(/themoviedb\:\/\/(\d{3,})/).first.first
      @attributes.merge!('tmdb' => value)
    end

  end
end