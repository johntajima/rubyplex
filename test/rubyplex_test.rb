require "test_helper"

class PlexTest < Minitest::Test

  def test_that_it_has_a_version_number
    refute_nil ::Plex::VERSION
  end

  def test_plex_configure_sets_config
    Plex.configure do |config|
      config[:port] = 1
      config[:host] = "192.168.1.1"
      config[:token] = "token"
    end

    @server = Plex.server
    assert_equal 1, @server.config[:port]
    assert_equal "192.168.1.1", @server.config[:host]
    assert_equal "token", @server.config[:token]
  end

end
