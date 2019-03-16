require 'active_support'
require 'active_support/core_ext'
require 'json'
require 'dalli'
require 'rest-client'
require 'plex/version'
require 'plex/base'
require 'plex/sortable'
require 'plex/server'
require 'plex/section'
require 'plex/movie'
require 'plex/media'
require 'plex/errors'

module Plex

  DEFAULT_CONFIG = {
    host: '192.168.2.10',
    port: 32400,
    token: 'set-token-here',
    memcache_host: 'localhost',
    memcache_port: 11211
  }

  def self.config
    @config ||= DEFAULT_CONFIG
  end

  def self.configure
    yield(config)
  end

  def self.server
    Plex::Server.new(config)    
  end

  def self.cache
    @cache ||= begin
      url = "#{Plex.config[:memcache_host]}:#{Plex.config[:memcache_port]}"
      Dalli::Client.new(url, namespace: 'rubyplex', compress: true, expires_in: 10*60, serializer: JSON)
    end
  end
end