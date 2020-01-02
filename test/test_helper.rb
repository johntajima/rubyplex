$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "rubyplex"

require "minitest/autorun"
require 'webmock/minitest'
require 'vcr'

WebMock.disable_net_connect!

Plex.configure do |config|
  config[:host] = "localhost"
end

VCR.configure do |config|
  config.cassette_library_dir = "test/fixtures/vcr_cassettes"
  config.hook_into :webmock
end

@server = Plex.server