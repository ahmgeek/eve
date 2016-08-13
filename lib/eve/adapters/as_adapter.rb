require 'asana'
require 'eve/errors'

module Eve
  module Adapter
    module Asana
      extend Eve::Errors

      class << self

        def start(token)
          plug(token)
        end

        private

        def plug(token)
          ::Asana::Client.new do |c|
            c.authentication :access_token, token
          end
        end
      end
    end
  end
end
