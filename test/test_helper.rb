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
  show_all: 'library_2_all.json',
  show1: 'show_1.json',
  show2: 'show_2.json',
  episodes: '',
  movie1: 'movie_1.json'
}


def load_response(key)
  file = RESPONSES.fetch(key)
  open("test/fixtures/#{file}").read
end

