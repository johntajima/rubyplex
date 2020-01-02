$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "rubyplex"

require 'active_support'

require "minitest/autorun"
require 'webmock/minitest'
require 'vcr'

WebMock.disable_net_connect!

VCR.configure do |config|
  config.cassette_library_dir = "test/fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.default_cassette_options = {
    :serialize_with => :yaml
  }
end


