module Plex

  class Episode
    include Plex::Base

    attr_reader :medias

    def initialize(hash)
      #@show = parent.key
      @attributes = hash.except('Media')
      @medias     = load_medias(hash)
      @attributes.merge!('medias' => @medias)
      add_accessible_methods
    end

    def episode
      attributes.fetch('index')
    end

    def season
      attributes.fetch('parentIndex')
    end

    def duration
      attributes.fetch('duration')
    end    

    def inspect
      "#<Plex::Episode::#{object_id} #{@attributes}>"
    end


    private

    def load_medias(hash)
      medias = hash.fetch("Media", [])
      medias.map {|entry| Plex::Media.new(entry) }
    end
  end
  
end