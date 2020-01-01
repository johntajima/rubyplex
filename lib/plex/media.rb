module Plex
  class Media
    include Plex::Base

    attr_reader :entry

    def initialize(hash, parent: nil)
      @attributes = hash
      @attributes.merge!({"file_id" => file_id, "file" => file, "file_size" => file_size, "file_duration" => file_duration})
      @entry = parent.key
      add_accessible_methods
    end


    def file_id 
      parts.first.fetch('id')
    end

    def file
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

    private

  end

end
