module Plex

  module Base

    DATE_FIELDS = [ 'originallyAvailableAt' ]
    TIME_FIELDS = [ 'addedAt', 'updatedAt', 'scannedAt']

    attr_reader :attributes, :hash

    def keys
      attributes.keys
    end


    private

    def init_attributes(hash)
      @attributes = self.class::MAP.inject({}) do |h,obj|
        field = obj.last
        value = hash[field]
        if value
          h[obj.first] = if TIME_FIELDS.include?(field)
            Time.at(value)
          elsif DATE_FIELDS.include?(field)
            value.to_time
          elsif hash[field].is_a?(Array)
            if field == 'Location'
              value.map {|entry| entry.fetch('path',nil)}.compact
            else
              value.map {|entry| entry.fetch('tag',nil)}.compact
            end
          else
            value
          end
        end
        h
      end
      add_accessible_methods
    end

    def add_accessible_methods
      @attributes.keys.each do |key|
        define_singleton_method(key) {
          @attributes.fetch(key, nil) 
        }
      end
    end


    def server
      @server ||= Plex::Server.new(Plex.config)
    end

  end

end