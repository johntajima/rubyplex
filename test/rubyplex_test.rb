require "test_helper"

class PlexTest < Minitest::Test

  def test_that_it_has_a_version_number
    refute_nil ::Plex::VERSION
  end

  def test_default_config_values
    File.expects(:exist?).returns(false)

    @config = Plex.config
    assert_equal Plex::DFLT_HOST, @config[:host]
    assert_equal Plex::DFLT_PORT, @config[:port]
    assert_equal Plex::DFLT_TOKEN, @config[:token]
  end

  def test_config_file
    yaml = <<-EOF
PLEX_HOST: '1.1.1.1'
PLEX_PORT: 1234
PLEX_TOKEN: 'my-token'
EOF

    File.expects(:exist?).returns(true)
    File.expects(:read).returns(yaml)

    @config = Plex.config
    assert_equal '1.1.1.1', @config[:host]
    assert_equal 1234, @config[:port]
    assert_equal 'my-token', @config[:token]
  end

  def test_config_file_takes_default_value_when_params_is_nil
    yaml = <<-EOF
PLEX_HOST:
PLEX_PORT:
PLEX_TOKEN: 'my-token'
EOF
    File.expects(:exist?).returns(true)
    File.expects(:read).returns(yaml)

    @config = Plex.config
    assert_equal Plex::DFLT_HOST, @config[:host]
    assert_equal Plex::DFLT_PORT, @config[:port]
  end

  def test_config_file_uses_default_when_param_is_missing
    yaml = <<-EOF
PLEX_HOST:
PLEX_TOKEN: 'my-token'
EOF

    File.expects(:exist?).returns(true)
    File.expects(:read).returns(yaml)

    @config = Plex.config
    assert_equal Plex::DFLT_HOST, @config[:host]
    assert_equal Plex::DFLT_PORT, @config[:port]
  end

  def test_set_plex_config
    config = {
      host: '2.2.2.2',
      port: 123,
      token: 'test-token'
    }

    @server = Plex.server(config)
    assert_equal '2.2.2.2', @server.host
    assert_equal 123, @server.port
    assert_equal 'test-token', @server.token
  end

end
