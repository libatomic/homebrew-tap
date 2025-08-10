require "formula"

class EnvTest < Formula
    env :std
    desc "Test env passthrough"
    homepage "https://example.com"
    head "https://github.com/Homebrew/brew.git"
  
    def install
      ohai "BREW_GH_PAT=#{ENV["BREW_GH_PAT"]}"
  
      # install a tiny script so formula is valid
      (bin/"env-test").write <<~SH
        #!/bin/sh
        echo "env-test OK"
      SH
    end
  end