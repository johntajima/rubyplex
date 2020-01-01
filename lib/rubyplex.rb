require 'active_support'
require 'active_support/core_ext'
require 'json'
require 'rest-client'
require 'plex/version'
require 'plex/base'
require 'plex/sortable'
require 'plex/server'
require 'plex/library'
require 'plex/show_library'
require 'plex/movie_library'

require 'plex/show'
require 'plex/episode'
require 'plex/movie'
require 'plex/media'

require 'plex/errors'

module Plex

  DEFAULT_CONFIG = {
    host: '192.168.2.5',
    port: 32400,
    token: '_3ZFfNvrYhZ9awqszJ_m',
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
end