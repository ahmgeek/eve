module Eve
  module Errors
    InvalidAuthentication = Class.new(StandardError)
    AlreadyAuthenticated  = Class.new(StandardError)
  end
end
