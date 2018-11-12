module Plex
  class Media
    include Plex::Base

    def initialize(hash)
      @attributes = hash
      add_accessible_methods
    end

    def file
      parts.first.fetch('file')
    end

    def file_size
      parts.first.fetch('size')
    end

    def parts
      attributes.fetch('Part')
    end


    private

  end

end
