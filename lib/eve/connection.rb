require 'eve/adapters/as_adapter'
require 'eve/adapters/gh_adapter'

module Eve
  class Connection
    attr_reader :github, :asana

    def initialize
      if auth_tokens_exists?
        connect
      elsif auth_tokens[:github].nil?
        Eve::Adapter::Github.initiate(interface)
        connect
      end
    end

    def connect
      begin
        @github = Eve::Adapter::Github.start(auth_token[:github])
        @asana  = Eve::Adapter::Asana.start(auth_token[:asana])
      rescue => e
       puts e.message
      end
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
      gh_token  = Eve::AuthTokenFile.read_gh_token rescue nil
      as_token  = Eve::AuthTokenFile.read_as_token rescue nil

      return { github: gh_token, asana: as_token }
_  end
  end
end
