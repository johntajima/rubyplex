module Plex

  class Base

    attr_reader   :hash, :server

    DATE_ATTRIBUTES = %w|updatedAt createdAt scannedAt originallyAvailableAt|

    def initialize(hash, server:)
      @hash = hash
      @server = server
    end

    def method_missing(arg, *params)
      key = convert_to_camel(arg.to_s)
      super unless hash.key?(key)
      value = hash.fetch(key, nil)
      # sanitize output
      if DATE_ATTRIBUTES.include?(key)
        Time.at(value)
      else
        value
      end
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


    def convert_to_camel(arg)
      list = arg.split("_")
      return arg if list.size == 1
      first = list.shift
      rest = list.map(&:capitalize).join
      "#{first}#{rest}"
    end

  end

end