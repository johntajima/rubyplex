require "test_helper"

class ServerTest < Minitest::Test

  def setup
    @server = Plex.server
  end

  # .libraries()

  def test_libraries
    libraries = VCR.use_cassette("libraries",:match_requests_on => [:path]) do
      @server.libraries
    end
    assert_equal 3, libraries.count
    assert libraries.first.is_a?(Plex::Library)
  end

  # .library()

  def test_library_returns_library_with_given_key
    library = VCR.use_cassette("libraries",:match_requests_on => [:path]) do
      @server.library(2)
    end
    assert_equal "TV Shows", library.title
  end

  def test_library_returns_library_with_given_title
    library = VCR.use_cassette("libraries",:match_requests_on => [:path]) do
      @server.library("Movies")
    end
    assert_equal "Movies", library.title
    assert_equal 1, library.id
  end


  # .library_by_path()

  def test_library_by_path_returns_library_with_given_directory_full_path
    library = VCR.use_cassette("libraries",:match_requests_on => [:path]) do
      @server.library_by_path("/volume1/Media/Movies")
    end
    assert_equal "Movies", library.title
  end

  def test_library_by_path_returns_library_with_directory_that_has_subdirs
    library = VCR.use_cassette("libraries",:match_requests_on => [:path]) do
      @server.library_by_path("/volume1/Media/Movies/Aliens")
    end
    assert_equal "Movies", library.title
  end

  def test_library_by_path_returns_library_with_directory_that_many_subdirs
    library = VCR.use_cassette("libraries",:match_requests_on => [:path]) do
      @server.library_by_path("/volume1/Media/Movies/Aliens/Featurettes/subtitles")
    end
    assert_equal "Movies", library.title
  end

  def test_library_by_path_returns_nil_if_directory_is_not_one_in_a_library
    library = VCR.use_cassette("libraries",:match_requests_on => [:path]) do
      @server.library_by_path("/volume1/Media/Movies_not_location")
    end
    assert_nil library
  end

  # .query()

  def test_query_sends_query_to_plex
  end

  def test_query_supports_page_and_per_page_params
  end

end
