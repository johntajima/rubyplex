$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "rubyplex"
require "minitest/autorun"
require 'webmock/minitest'
require 'mocha/minitest'


WebMock.disable_net_connect!

RESPONSES = {
  movie_count: 'movies_total_count.json',
  show_count: 'shows_total_count.json',
  libraries: 'libraries.json',
  library_1: 'library_1.json',
  library_2: 'library_2.json',
  show_1: 'show_1.json',
  show_2: 'show_2.json',
  episodes: '',
  movie1: 'movie_1.json',
  show_1_details: 'show_details.json'
}
 
 
def load_response(key)
  file = RESPONSES.fetch(key)
  open("test/fixtures/#{file}").read
end