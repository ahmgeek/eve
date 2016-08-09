module Eve
  InvalidAuthentication = Class.new(StandardError)

  class Connection
    def initialize(credentials={})
      username = credentials[:username]
      password = credentials[:password]

      client = Octokit::Client.new(login: username, password: password)
      token  = client.create_authorization(scopes: [:user, :repo, :gist], note: 'Heba, the secretary').token

      AuthTokenFile.write token
    end

    # @return [string] of access token or nil
    def auth_token
      @token ||= AuthTokenFile.read rescue nil
    end
  end
end

