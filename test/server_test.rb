# require "test_helper"

# class ServerTest < Minitest::Test

#   def setup
#     @server = Plex.server
#   end

#   # .libraries()

#   def test_libraries
#     stub_request(:get, @server.query_path("/library/sections")).to_return(body: load_response(:libraries))
#     libraries = @server.libraries
#     assert_equal 3, libraries.count
#     assert libraries.first.is_a?(Plex::Library)
#   end

#   # .library()

#   def test_library_returns_library_with_given_key
#     stub_request(:get, @server.query_path("/library/sections")).to_return(body: load_response(:libraries))
#     library = @server.library(2)
#     assert_equal "TV Shows", library.title
#   end

#   def test_library_returns_library_with_given_title
#     stub_request(:get, @server.query_path("/library/sections")).to_return(body: load_response(:libraries))
#     library = @server.library("Movies")
#     assert_equal "Movies", library.title
#     assert_equal 1, library.id
#   end


#   # # .library_by_path()

#   def test_library_by_path_returns_library_with_given_directory_full_path
#     stub_request(:get, @server.query_path("/library/sections")).to_return(body: load_response(:libraries))
#     library = @server.library_by_path("/volume1/Media/Movies")
#     assert_equal "Movies", library.title
#   end

#   def test_library_by_path_returns_library_with_directory_that_has_subdirs
#     stub_request(:get, @server.query_path("/library/sections")).to_return(body: load_response(:libraries))
#     library = @server.library_by_path("/volume1/Media/Movies/Aliens")
#     assert_equal "Movies", library.title
#   end

#   def test_library_by_path_returns_library_with_directory_that_many_subdirs
#     stub_request(:get, @server.query_path("/library/sections")).to_return(body: load_response(:libraries))
#     library = @server.library_by_path("/volume1/Media/Movies/Aliens/Featurettes/subtitles")
#     assert_equal "Movies", library.title
#   end

#   def test_library_by_path_returns_nil_if_directory_is_not_one_in_a_library
#     stub_request(:get, @server.query_path("/library/sections")).to_return(body: load_response(:libraries))
#     library = @server.library_by_path("/volume1/Media/Movies_not_location")
#     assert_nil library
#   end

#   # # .query()

#   # def test_query_sends_query_to_plex
#   # end

#   # def test_query_supports_page_and_per_page_params
#   # end

# end
