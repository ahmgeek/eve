require 'thor'
require 'octokit'

module Heba
  def constructor
    unless auth_token
      puts "--Heba needs to know who you are!"
      puts "Please enter Github username:"
      username = $stdin.gets.strip
      puts "Github password"
      password =  begin
        `stty -echo` rescue nil
        $stdin.gets.strip
      ensure
        `stty echo` rescue nil
      end

      client = Octokit::Client.new(login: username, password: password)
      token  = client.create_authorization(scopes: [:user, :repo, :gist], note: 'Heba, the secretary').token
      AuthTokenFile.write token
    end
  end

  # @return [string] of access token or nil
  def auth_token
    @token ||= AuthTokenFile.read rescue nil
  end
  # Helper module for authentication token actions
  module AuthTokenFile
    class << self
      def filename
        File.expand_path "~/.heba"
      end

      def read
        File.read(filename).chomp
      end

      def write(token)
        File.open(filename, "w", 0600) do |f|
          f.write token
        end
      end
    end
  end
end

