require 'octokit'
require 'eve/auth_token_file'
require 'eve/errors.rb'

module Eve
  class Connection
    def initialize(credentials = {})
      username = credentials[:username]
      password = credentials[:password]
      token = nil
      begin
        client = Octokit::Client.new(login: username, password: password)
        token = client.create_authorization(scopes: [:user, :repo, :gist],
                                           note: "Eve(#{Time.now}").token
        AuthTokenFile.write token

      rescue Octokit::Unauthorized, Octokit::NotFound
        raise InvalidAuthentication

      rescue Octokit::UnprocessableEntity => e
        raise AlreadyAuthenticated if e.message.include?("already_exists")
      end
    end
  end
end
