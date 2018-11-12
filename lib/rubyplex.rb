require 'active_support'
require 'active_support/core_ext'
require 'json'
require 'rest-client'
require 'rubyplex/version'
require 'rubyplex/base'
require 'rubyplex/server'
require 'rubyplex/section'
require 'rubyplex/movie'
require 'rubyplex/media'

module Plex

  DEFAULT_CONFIG = {
    host: '192.168.2.10',
    port: 32400,
    token: 'set-token-here'
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


  class NotFoundError < StandardError; end
end

class String
  def is_int?
    self.to_i.to_s == self
  end
end