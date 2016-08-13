# Helper module for authentication token actions.
# AuthTokenFIle#write Works only with Github for now.
module Eve
  class AuthTokenFile
    class << self
      def github_token
        File.expand_path '~/.eve_gh'
      end

      def asana_token
        File.expand_path '~/.eve_as'
      end

      def read_gh_token
        File.read(github_token).chomp rescue nil
      end

      def read_as_token
        File.read(asana_token).chomp rescue nil
      end

      def write(token)
        File.open(github_token, 'w', 0600) do |f|
          f.write token
        end
      end
    end
  end
end
