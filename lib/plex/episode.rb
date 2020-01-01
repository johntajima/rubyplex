module Plex
  class Episode
    include Plex::Base

    attr_reader :show, :medias

    def initialize(hash, parent: nil)
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

    def key
      attributes.fetch('ratingKey')
    end

    private

    def load_medias(orig_hash)
      list = orig_hash.fetch('Media', [])
      list.map {|entry| Plex::Media.new(entry, parent: self) }
    end
  end
end