 # Helper module for authentication token actions
class Eve::AuthTokenFile
  class << self
    def filename
      File.expand_path '~/.eve_gh'
    end

    def read
      File.read(filename).chomp
    end

    def write(token)
      File.open(filename, 'w', 0600) do |f|
        f.write token
      end
    end
  end
end
