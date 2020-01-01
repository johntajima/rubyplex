module Plex
  
  class Show
    include Plex::Base
    include Plex::Sortable

    def initialize(hash)
      @attributes = hash.except('Media')
      @attributes.merge!('total_seasons' => total_seasons, 'total_episodes' => total_episodes)
      add_accessible_methods
    end

    def tvdb
      #{}"guid"=>"com.plexapp.agents.thetvdb://279536?lang=en"
    end

    def total_seasons
      attributes.fetch('childCount')
    end

    def total_episodes
      attributes.fetch('leafCount')
    end

    def episodes
      @episodes ||= load_episodes(attributes)
    end

    private

    def load_episodes(orig_hash)
      list = Plex.server.query(leaf_url).fetch("Metadata")
      list.map {|entry| Plex::Episode.new(entry, parent: self) }
    end

    def leaf_url
      "/library/metadata/#{attributes['ratingKey']}/allLeaves"
    end
  end
end