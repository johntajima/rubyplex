require "test_helper"

class LibraryTest < Minitest::Test
  
  # def setup
  #   @library_params = {"allowSync"=>true,
  #     "art"=>"/:/resources/movie-fanart.jpg",
  #     "composite"=>"/library/sections/8/composite/1542179087",
  #     "filters"=>true,
  #     "refreshing"=>false,
  #     "thumb"=>"/:/resources/movie.png",
  #     "key"=>"8",
  #     "type"=>"movie",
  #     "title"=>"4K Movies",
  #     "agent"=>"com.plexapp.agents.imdb",
  #     "scanner"=>"Plex Movie Scanner",
  #     "language"=>"en",
  #     "uuid"=>"36b7bf82-784e-4c0c-a219-e51549ebc255",
  #     "updatedAt"=>1536625963,
  #     "createdAt"=>1512309737,
  #     "scannedAt"=>1542179087,
  #     "Location"=>
  #      [{"id"=>17, "path"=>"/volume4/Media2/Movies_HQ"},
  #       {"id"=>22, "path"=>"/volume4/Media2/hq_downloads"}]}
  # end

  # # .new
  # def test_new_library_creates_library_model
  #   @library = Plex::Library.new(@library_params)
  #   assert @library.is_a?(Plex::Library)
  #   assert_equal 8, @library.id
  #   assert_equal "4K Movies", @library.title
  #   assert_equal 2, @library.directories.count
  # end

  # # .total_count
  # def test_total_returns_total_entries_in_library_for_movies
  #   @library =  @library = VCR.use_cassette("libraries",:match_requests_on => [:path]) do
  #     Plex.server.library(1)
  #   end

  #   assert_equal "Movies", @library.title
  #   count = VCR.use_cassette("movie_total_count",:match_requests_on => [:path]) do
  #     @library.total_count
  #   end
  #   assert_equal 100, count
  # end

  # def test_total_returns_total_entries_in_library_for_shows
  #   @library = VCR.use_cassette("libraries",:match_requests_on => [:path]) do
  #     Plex.server.library(2)
  #   end
  #   assert_equal "TV Shows", @library.title
  #   count = VCR.use_cassette("show_total_count",:match_requests_on => [:path]) do
  #     @library.total_count
  #   end
  #   assert_equal 50, count
  # end

  # # .all
  # def test_all_returns_all_movies
  #   @library = VCR.use_cassette("libraries",:match_requests_on => [:path]) do
  #     Plex.server.library(3)
  #   end
    
  #   #stub_request(:any, "http://192.168.2.5/library/sections/#{@library.id}/all").to_return(File.read("test/fixtures/library_all.txt"))

  #   #movies = @library.all

  #   #assert_equal 5, movies.count
  # end

  def test_all_returns_all_shows
  end

  def test_all_with_per_page_options
  end

  def test_all_with_pagination
  end



  # various query methods
  def test_newest_sends_right_query_string_to_server
  end

  # .find_by_filename
  def test_find_by_filename_returns_media_model_for_movie
  end

  # .find_by_filename
  def test_find_by_filename_returns_media_model_for_show
  end


  # .to_hash
  def test_to_hash
  end

  # .movie_library?
  def test_movie_library_returns_true_if_library_is_for_movies
  end

  def test_movie_library_returns_false_if_library_is_for_shows
  end

end
