module Eve
  class ::String
    def strip_heredoc
      gsub(/^#{scan(/^\s*/).min_by{|l|l.length}}/, "")
    end
  end
end
