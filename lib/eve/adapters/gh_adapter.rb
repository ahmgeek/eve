require 'octokit'
require 'eve/auth_token_file'
require 'eve/errors'

module Eve
  module Adapter
    module Github
      extend Eve::Errors

      class << self

        def initiate(credentials = {})
          username = credentials[:username]
          password = credentials[:password]
          begin
            client = plug(login: username, password: password)
            token = client.create_authorization(scopes: [:user, :repo, :gist],
                                                note: "Eve(#{Time.now}").token
            Eve::AuthTokenFile.write(token)

          rescue Octokit::Unauthorized, Octokit::NotFound
            raise InvalidAuthentication

          rescue Octokit::UnprocessableEntity => e
            raise AlreadyAuthenticated if e.message.include?('already_exists')
          end
        end

        def start(token)
          plug(access_token: token)
        end

        private

        def plug(args)
          Octokit::Client.new(args)
        end
      end
    end
  end
end
