require 'thor'
require 'octokit'

module Eve
  def constructor
    unless auth_token
      puts "--Eve needs to know who you are!"
      puts "Please enter Github username:"
      username = $stdin.gets.strip
      puts "Github password"
      password =  begin
        `stty -echo` rescue nil
        $stdin.gets.strip
      ensure
        `stty echo` rescue nil
      end
    end
  end
end

