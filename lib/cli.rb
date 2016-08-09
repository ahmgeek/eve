require 'thor'
require 'eve/connection'

# The Secretary
module Eve
  def constructor
    puts '--Eve needs to know who you are!'
    return if auth_token

    Connection.new(setup)
  end

  def setup
    puts 'Please enter Github username:'
    username = $stdin.gets.strip
    puts 'Github password'
    password = begin
      `stty -echo` rescue nil
      $stdin.gets.strip
    ensure
      `stty echo` rescue nil
    end
    { username: username, password: password }
  end

  # @return [string] of access token or nil
  def auth_token
    @token ||= AuthTokenFile.read rescue nil
  end
end
