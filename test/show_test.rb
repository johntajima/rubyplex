require "test_helper"

class ShowTest < Minitest::Test
  
  def setup
    @server = Plex.server
    stub_request(:get, @server.query_path("/library/sections")).to_return(body: load_response(:libraries))
    stub_request(:get, @server.query_path("/library/sections/2/all")).to_return(body: load_response(:library_2))
    stub_request(:get, @server.query_path("/library/metadata/10401/allLeaves")).to_return(body: load_response(:show_1))
    stub_request(:get, @server.query_path("/library/metadata/10320/allLeaves")).to_return(body: load_response(:show_2))
    @library = Plex.server.library(2)
  end


  # new

  def test_new_show
    @show = @library.all.first
    assert_equal 10, @show.episodes_count
    assert_equal 1, @show.seasons_count
    assert_equal "show", @show.type

    assert_equal 10, @show.episodes.count
  end


  # find_by_filename 

  def test_find_by_file_returns_media_if_found
    @show = @library.all.first
    file = "Band of Brothers S01E01 [1080p].mp4"

    found = @show.find_by_filename(file)
    assert found.is_a?(Plex::Episode)
    media = found.media_by_filename(file)
    assert media.has_file?(file)
  end

  def test_find_by_filename_returns_nil_if_file_doesnt_exist
    @show = @library.all.first
    file = "Bad file Band of Brothers S01E01 [1080p].mp4"

    assert_nil @show.find_by_filename(file)
  end


  def test_seasons_count
    @show = @library.all.first
    assert_equal 1, @show.seasons_count
  end

  def test_episodes_count
    @show = @library.all.first
    assert_equal 10, @show.episodes_count
  end

  # season()

  def test_season_returns_all_episodes_for_a_selected_season
    @show = @library.all.first
    @episodes = @show.season(1)
    assert_equal 10, @episodes.count
    assert @episodes.first.is_a?(Plex::Episode)
    assert @episodes.all? {|e| e.season == 1}
  end

  def test_season_returns_empty_if_season_is_invalid
    @show = @library.all.first
    @episodes = @show.season(2)
    assert_equal 0, @episodes.count    
  end


  # episodes

  def test_episodes_returns_array_of_all_episodes
    @show = @library.all.first
    @episodes = @show.episodes
    assert_equal 10, @episodes.count
    assert @episodes.first.is_a?(Plex::Episode)
  end
  

  # episode(season, index)

  def test_episode_returns_episode_for_given_season_and_index
    @show = @library.all.first
    @episode = @show.episode(1,5)
    assert_equal 1, @episode.season
    assert_equal 5, @episode.episode
  end

  def test_episode_returns_nil_if_season_is_invalid
    @show = @library.all.first
    assert_nil @show.episode(2,5)
  end

  def test_episode_returns_nil_if_episode_is_invalid
    @show = @library.all.first
    assert_nil @show.episode(1,11)
  end

end
