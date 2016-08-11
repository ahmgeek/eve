class Eve::Errors
  Eve::Errors::InvalidAuthentication = Class.new(StandardError)
  Eve::Errors::AlreadyAuthenticated  = Class.new(StandardError)
end
