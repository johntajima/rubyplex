module Plex

  class Base

    attr_reader   :hash, :server

    TIME_ATTRIBUTES = %w|updatedAt createdAt addedAt scannedAt|
    DATE_ATTRIBUTES = ["originallyAvailableAt"]
    TAG_ATTRIBUTES  = ["Genre", "Director", "Writer", "Country", "Role", "Guid"]

    def initialize(hash, server: nil)
      @hash = hash
      @server = server
    end

    def method_missing(arg, *params)
      key = convert_to_camel(arg.to_s)
      
      return tag_values(key) if hash.key?(key.capitalize)
      super unless hash.key?(key)

      value = hash.fetch(key, nil)
      if TIME_ATTRIBUTES.include?(key)
        Time.at(value)
      elsif DATE_ATTRIBUTES.include?(key)
        Date.parse(value)
      else
        value
      end
    end

    def guids
      tag_values('Guid')
    end

    def keys
      hash.keys
    end

    def to_hash
      hash
    end

    def to_json
      hash.to_json
    end


    private

    def tag_values(key)
      entries = hash.fetch(key.capitalize,[])
      entries.map {|entry| entry['tag'] }
    end

    def convert_to_camel(arg)
      list = arg.split("_")
      return arg if list.size == 1
      first = list.shift
      rest = list.map(&:capitalize).join
      "#{first}#{rest}"
    end

  end

end