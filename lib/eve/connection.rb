require 'eve/adapters/as_adapter'
require 'eve/adapters/gh_adapter'

module Eve
  class Connection
    attr_reader :github, :asana

    # TODO(ahmgeek): Better error handling
    # if tokens are not set.
    def initialize
      if auth_tokens_exists?
        connect
      elsif auth_token[:github].nil?
        Eve::Adapter::Github.initiate(interface)
        connect
      elsif auth_token[:asana].nil?
        error_message = <<-HEREDOC
-- Eve couldn't find Asana's token file,
- Please follow the inestructions at the
- README to know how to create one
        HEREDOC
        puts error_message
      else
        connect
      end
    end

    def connect
      @github = Eve::Adapter::Github.start(auth_token[:github])
      @asana  = Eve::Adapter::Asana.start(auth_token[:asana])
    end

    def interface
      welcome_message = <<-HEREDOC
-- Eve needs to recognize you
--------------------------------------------
- For Asana authentication, get back README 
- #Asana section and follow instructions.
--------------------------------------------
      HEREDOC

      puts welcome_message

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

    private

    def auth_tokens_exists?
      Eve::AuthTokenFile.read_gh_token && Eve::AuthTokenFile.read_as_token
    end

    def auth_token
      gh_token  = Eve::AuthTokenFile.read_gh_token
      as_token  = Eve::AuthTokenFile.read_as_token

      return { github: gh_token, asana: as_token }
    end
  end
end
