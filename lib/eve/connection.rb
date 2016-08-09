require 'octokit'
require 'eve/auth_token_file'

module Eve
  InvalidAuthentication = Class.new(StandardError)

  # Connections handler
  # Fix when user have token but uses another machine
  class Connection
    def initialize(credentials = {})
      username = credentials[:username]
      password = credentials[:password]

      client = Octokit::Client.new(login: username, password: password)
      token  = client.create_authorization(scopes: [:user, :repo, :gist],
                                           note: 'Eve, the secretary').token
      AuthTokenFile.write token
    end
  end
end
