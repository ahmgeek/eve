require 'octokit'
require 'eve/auth_token_file'
require 'eve/errors.rb'

module Eve
  module Connection
    class << self
      attr_reader :client

      def initiate(credentials = {})
        username = credentials[:username]
        password = credentials[:password]
        begin
          @client = plug(login: username, password: password)
          token = client.create_authorization(scopes: [:user, :repo, :gist],
                                              note: "Eve(#{Time.now}").token
          AuthTokenFile.write token

        rescue Octokit::Unauthorized, Octokit::NotFound
          raise InvalidAuthentication

        rescue Octokit::UnprocessableEntity => e
          raise AlreadyAuthenticated if e.message.include?('already_exists')
        end
      end

      def start(token)
        @client = plug(access_token: token)
      end

      private

      def plug(arg)
        Octokit::Client.new(arg)
      end
    end
  end
end
