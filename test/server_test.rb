require "test_helper"

class ServerTest < Minitest::Test

  def setup
    @server = Plex.server
    stub_request(:get, @server.query_path("/library/sections")).to_return(status: 200, body: load_response(:libraries))
  end


  # .query_path

  def test_query_path_returns_full_url
    @path = "/libraries/sections"
    @url = @server.query_path(@path)

    assert @url.start_with?("http")
    assert_equal "http://192.168.2.5:32400/libraries/sections", @url

    @path2 = "libraries/sections"
    @url2 = @server.query_path(@path)

    assert_equal @url2, @url
  end


  # .libraries()
  
  def test_libraries_returns_array_of_libraries    
    @libraries = @server.libraries

    assert_equal 3, @libraries.count
    assert_equal "4K Movies", @libraries.first.title
    assert_equal "TV Shows", @libraries.last.title
  end


  # .library()

  def test_library_returns_library_with_given_key    
    library = @server.library(2)

    assert_equal "TV Shows", library.title
  end

  def test_library_returns_nil_if_invalid_library
    library = @server.library(21)
    assert_nil library
  end

  def test_library_returns_library_with_given_title
    library = @server.library("Movies")
    assert_equal "Movies", library.title
  end


  # .library_by_path()

  def test_library_by_path_returns_library_with_given_directory_full_path
    library = @server.library_by_path("/volume1/Media/Movies")
    assert_equal "Movies", library.title
  end

  def test_library_by_path_returns_library_with_directory_that_has_subdirs
    library = @server.library_by_path("/volume1/Media/Movies/Aliens")
    assert_equal "Movies", library.title
  end

  def test_library_by_path_returns_library_with_directory_that_many_subdirs
    library = @server.library_by_path("/volume1/Media/Movies/Aliens/Featurettes/subtitles")
    assert_equal "Movies", library.title
  end

  def test_library_by_path_returns_nil_if_directory_is_not_one_in_a_library
    library = @server.library_by_path("/volume1/Media/Movies_not_location")
    assert_nil library
  end

  def test_library_by_path_returns_library_if_locations_include_path_with_different_root
    path = "/Volumes/Media/Movies"
    library = @server.library_by_path(path)
    assert_equal "Movies", library.title

    path = "/volume1/data/Media/Movies"
    library = @server.library_by_path(path)
    assert_equal "Movies", library.title
  end


  # query()

  def test_query_send_proper_request
    stub_request(:get, @server.query_path("/library/sections/3/all")).to_return(status: 200, body: "{}", headers: {})
    @library = @server.libraries.first

    assert @library.all
  end

  def test_query_support_pagination
    @url = "http://192.168.2.5:32400/library/sections/3/all?X-Plex-Container-Size=2&X-Plex-Container-Start=0"
    stub_request(:get, @url).to_return(status: 200, body: "{}", headers: {})
    @library = @server.libraries.first
    assert @library.all(options: {page:1, per_page: 2})
  end


  # data_query()

  def test_data_query_returns_contents_of_Metadata_field
    @library = @server.libraries.first
    stub_request(:get, @server.query_path("/library/metadata/17911")).to_return(status: 200, body: load_response(:movie1), headers: {})

    resp = @server.data_query("/library/metadata/17911")
    assert_equal "17911", resp.first['ratingKey']

    resp2 = @server.query("/library/metadata/17911")
    assert_equal resp, resp2['Metadata']
  end
  

end
