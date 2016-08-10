require 'thor'
require 'eve/connection'

# The Secretary
module Eve
  include Connection

  def self.prepare
    if auth_token
      @client = Connection.start(auth_token)
      puts "hey #{@client.login}, Welcome Back!"
    else
      Connection.initiate(interface)
      prepare
    end
  end

  private

  def interface
    puts '-- Eve needs to recognize you'
    puts 'Please enter Github username:'
    username = $stdin.gets.strip
    puts 'and your Github password'
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
