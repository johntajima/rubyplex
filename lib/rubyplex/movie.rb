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
  end

end