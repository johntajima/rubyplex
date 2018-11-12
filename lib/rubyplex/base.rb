module Plex

  module Base

    attr_reader :attributes

    private

    def add_accessible_methods
      @attributes.keys.each do |key|
        next unless valid_attribute_method?(key)
        define_singleton_method(key.underscore) {
          @attributes.fetch(key, nil) 
        }
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