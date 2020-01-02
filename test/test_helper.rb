$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "rubyplex"

require 'active_support'

require "minitest/autorun"
require 'webmock/minitest'

WebMock.disable_net_connect!

RESPONSES = {
  movie_count: 'movies_total_count.json',
  show_count: 'shows_total_count.json',
  libraries: 'libraries.json',
  library_1: 'library_1.json',
  movie_all: 'library_1_all.json',
  show_all: '',
  show: '',
  episodes: '',
  movie: ''
}


def load_response(key)
  file = RESPONSES.fetch(key)
  open("test/fixtures/#{file}").read
end

