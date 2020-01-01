module Plex

  module Base

    DATE_FIELDS = [ 'originalAvailableAt']
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
        h[obj.first] = if DATE_FIELDS.include?(field)
          Time.at(value)
        elsif TIME_FIELDS.include?(field)
          value.to_time
        else
          value
        end
        h
      end
      add_accessible_methods
    end

    def add_accessible_methods
      @attributes.keys.each do |key|
        next unless valid_attribute_method?(key)
        if key.is_a?(String)
          define_singleton_method(key.underscore) {
            @attributes.fetch(key, nil) 
          }
        else
          define_singleton_method(key) {
            @attributes.fetch(key, nil) 
          }
        end
      end
    end

    def valid_attribute_method?(key)
      return if @attributes.fetch(key).is_a?(Array)
      true
    end

    def server
      @server ||= Plex::Server.new(Plex.config)
    end

  end

end