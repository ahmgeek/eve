require 'eve/version'
require 'eve/auth_token_file'
require 'eve/connection'

module Eve
  def self.start
    @connection = Connection.new
  end
end
