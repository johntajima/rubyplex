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


  def test_episode_attributes
    @episode = @show.episodes.first
    assert_equal 10403, @episode.id
    assert_equal "/library/metadata/10401", @episode.show_key
    assert_equal "Band of Brothers", @episode.show_title
    assert_equal 1, @episode.season
    assert_equal 1, @episode.episode
    assert_equal "Season 1", @episode.season_title    
  end


  # has_file?

  def test_by_file_returns_media_if_episode_has_file
    @episode = @show.episodes.first
    file = "/volume1/Media/TV/Band of Brothers/Band of Brothers S01/Band of Brothers S01E01 [1080p].mp4"
    file2 = "Band of Brothers S01E01 [1080p].mp4"
    assert @episode.by_file(file).is_a?(Plex::Media)
    assert @episode.by_file(file2).is_a?(Plex::Media)
  end


  # .show

  def test_show_returns_show_model_for_given_episode
    stub_request(:get, @server.query_path("/library/metadata/10401")).to_return(body: load_response(:show_1_details))
    
    @episode = @show.episodes.first
    @parent = @episode.show
    assert_equal @show.id, @parent.id
    assert_equal @show.episodes.count, @parent.episodes.count
  end
end
