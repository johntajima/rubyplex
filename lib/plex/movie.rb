module Plex
  class Movie
    include Plex::Base

    attr_reader :medias


    def initialize(hash)
      @attributes = hash.except('Media')
      @medias     = init_medias(hash.slice('Media'))
      @attributes.merge!('medias' => @medias)
      add_accessible_methods
    end

    def imdb
      @imdb ||= begin
        value = attributes.fetch('imdb', nil)
        load_imdb if value.nil?
        attributes.fetch('imdb')
      end
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


    private

    def init_medias(medias)
      list = medias.fetch('Media', [])
      list.map {|entry| Plex::Media.new(entry) }
    end

    def load_imdb
      movie = Plex.server.query(key)
      metadata = movie.fetch('Metadata').first
      guid = metadata.fetch('guid')
      imdb_id = guid.scan(/tt\d{3,}/).first if guid.match('imdb')
      @attributes.merge!('imdb' => imdb_id)
    end
  end

end