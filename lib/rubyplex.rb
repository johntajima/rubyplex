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

  DFLT_CONFIG_FILE = File.expand_path("../rubyplex.yml")
  HOME_CONFIG_FILE = File.expand_path("~/.rubyplex.yml")

  config =   YAML.load(File.read(HOME_CONFIG_FILE)) if File.exists?(HOME_CONFIG_FILE) 
  config ||= YAML.load(File.read(DFLT_CONFIG_FILE)) if File.exists?(DFLT_CONFIG_FILE)
  
  DEFAULT_CONFIG = config.fetch("RUBYPLEX", {}).transform_keys(&:to_sym)

  extend self

  def server(options = {})
    Plex::Server.new(options)
  end

end