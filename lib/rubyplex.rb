require 'json'
require 'yaml'
require 'faraday'
require 'plex/version'
require 'plex/base'
require 'plex/server'
require 'plex/library'
require 'plex/movie'
require 'plex/show'
require 'plex/episode'
require 'plex/media'
require 'plex/part'
require 'plex/stream'

module Plex

  DFLT_HOST   = '127.0.0.1'
  DFLT_PORT   = 32400
  DFLT_TOKEN  = ''
  CONFIG_FILE = File.expand_path('~/.rubyplex.yml')
  
  extend self


  def dflt_config
    params = File.exist?(CONFIG_FILE) ? (YAML.load(File.read(CONFIG_FILE))) : {}
    {
      host: params.fetch('PLEX_HOST', nil) || DFLT_HOST,
      port: params.fetch('PLEX_PORT', nil) || DFLT_PORT,
      token: params.fetch('PLEX_TOKEN', nil) || DFLT_TOKEN
    }
  end

  def config
    dflt_config
  end

  def server(config = dflt_config)
    Plex::Server.new(config)
  end


end