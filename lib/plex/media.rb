module Plex

  class Media
    include Plex::Base

    def initialize(hash)
      @attributes = hash
      file_attributes = {
        "file_id"       => file_id,
        "file_name"     => file_name,
        "file_size"     => file_size,
        "file_duration" => file_duration
      }
      @attributes.merge!(file_attributes)
      add_accessible_methods
    end

    def file_id 
      parts.first.fetch('id')
    end

    def file_name
      parts.first.fetch('file')
    end

    def file_size
      parts.first.fetch('size')
    end

    def file_duration
      parts.first.fetch('duration',nil)
    end

    def parts
      attributes.fetch('Part')
    end

    def inspect
      "#<Plex::Media::#{object_id} #{@attributes}>"
    end
  end

end
