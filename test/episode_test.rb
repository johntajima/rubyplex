require "test_helper"

class EpisodeTest < Minitest::Test
  
  def setup
    @server = Plex.server
    stub_request(:get, @server.query_path("/library/sections")).to_return(body: load_response(:libraries))
    stub_request(:get, @server.query_path("/library/sections/2/all")).to_return(body: load_response(:library_2))
    stub_request(:get, @server.query_path("/library/metadata/10401/allLeaves")).to_return(body: load_response(:show_1))
    stub_request(:get, @server.query_path("/library/metadata/10320/allLeaves")).to_return(body: load_response(:show_2))
    @library = Plex.server.library(2)
    @show = @library.all.first
  end


  def test_show_title
    @ep = @show.episodes.first
    assert_equal "Band of Brothers", @ep.show_title
  end


  # media_by_filename

  def test_media_by_filename_returns_media_if_file_exists
    @episode = @show.episodes.first
    file = "/volume1/Media/TV/Band of Brothers/Band of Brothers S01/Band of Brothers S01E01 [1080p].mp4"
    file2 = "Band of Brothers S01E01 [1080p].mp4"
    assert @episode.media_by_filename(file).is_a?(Plex::Media)
    assert @episode.media_by_filename(file2).is_a?(Plex::Media)
  end


  # attributes

  def test_season_returns_episodes_season_number
    @episode = @show.episodes.first
    assert_equal 1, @episode.season
  end

  def test_season_returns_episodes_season_number
    @episode = @show.episodes.last
    assert_equal 10, @episode.episode
  end

  def test_label_returns_season_and_ep_in_nice_format
    @episode = @show.episodes.first
    assert_equal "S01E01", @episode.label     
  end

  def test_files_returns_array_of_media_filenames
    @episode = @show.episodes.first
    files = @episode.files
    assert_equal 1, files.count
  end
end
