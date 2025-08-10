require "formula"

class EnvTest < Formula
    env :std
    desc "Test env passthrough"
    homepage "https://example.com"
    head "https://github.com/Homebrew/brew.git"
  
    def install
      ohai "HOMEBREW_GITHUB_API_TOKEN=#{ENV["HOMEBREW_GITHUB_API_TOKEN"]}"
      ohai "GITHUB_TOKEN=#{ENV["GITHUB_TOKEN"]}"
      ohai "GH_TOKEN=#{ENV["GH_TOKEN"]}"
  
      # install a tiny script so formula is valid
      (bin/"env-test").write <<~SH
        #!/bin/sh
        echo "env-test OK"
      SH
    end
  end